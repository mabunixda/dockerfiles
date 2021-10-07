#!/bin/bash
set -e
set -o pipefail

DOCKER_BUILDKIT=${DOCKER_BUILDKIT:-1}
export DOCKER_BUILDKIT

BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
echo "Working on $BRANCH_NAME $GIT_BRANCH"
SCRIPT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
REPO_URL="${REPO_URL:-docker.io/mabunixda}"
JOBS=${JOBS:-2}
ERRORS="$(pwd)/errors"
BUILD_ARGS=${BUILD_ARGS:- --rm --force-rm --pull }
version_check="([0-9]+\.)?([0-9]+\.)?(\*|[0-9]+)"
if [ ! -z "$NO_CACHE" ]; then
    BUILD_ARGS="$BUILD_ARGS --no-cache "
fi

build_and_push(){
    base=$1
    suite=$2
    build_dir=$3

    if [ -e "${build_dir}/.skip" ]; then
        return
    fi

    echo "Building ${REPO_URL}/${base}:${suite} for context ${build_dir}"
    docker build --progress=plain $BUILD_ARGS -t ${REPO_URL}/${base}:${suite} ${build_dir} || return 1

    # on successful build, push the image
    echo "                       ---                                   "
    echo "Successfully built ${base}:${suite} with context ${build_dir}"

    if [ "$BRANCH_NAME" != "main" ]; then
        return
    fi
    docker push ${REPO_URL}/${base}:${suite}
    ehco "Successfuly pushed ${base}:${suite}"
    echo "                       ---                                   "

    # also push the tag latest for "stable" tags
    if [[ "$suite" == "stable" ]]; then
        echo "                       ---                                   "
        docker tag ${REPO_URL}/${base}:${suite} ${REPO_URL}/${base}:latest
        docker push ${REPO_URL}/${base}:latest
        echo "Successfully pushed ${base}:latest"
        echo "                       ---                                   "
    fi

    if [ "$(grep -c " VERSION=" "${build_dir}/Dockerfile")" != "0" ]; then
        container_version=$(grep " VERSION=" "${build_dir}/Dockerfile" | awk -F'=' '{print $2}')
        echo "                       ---                                   "
        echo "found version $container_version"
        docker tag ${REPO_URL}/${base}:${suite} ${REPO_URL}/${base}:${container_version}
        docker push ${REPO_URL}/${base}:${container_version}
        echo "Successfully pushed ${base}:${container_version}"
        echo "                       ---                                   "
    fi
    echo "done"

}


prefetch() {

    echo "Getting base images..."
    IMAGES=$(grep "^FROM " -R * | awk -F' ' '{print $2}' | grep -v "\${" | sort | uniq)
    if [ -e "/usr/bin/parallel" ] || [ -e "/usr/local/bin/parallel" ]; then
        parallel --tag --verbose --ungroup -j"${JOBS}" docker pull "{1}" ::: "${IMAGES[@]}"
    else
        for d in ${IMAGES}; do
            $(build_cmd) pull $d;
        done
    fi
    echo "  prefetch done"

}

dofile() {
    f=$1
    image=${f%Dockerfile}
    base=${image%%\/*}
    build_dir=$(dirname $f)
    suite=${build_dir##*\/}

    if [[ -z "$suite" ]] || [[ "$suite" == "$base" ]]; then
        suite=latest
    fi

    {
        $SCRIPT build_and_push "${base}" "${suite}" "${build_dir}"
        } || {
        # add to errors
        echo "${base}:${suite}" >> $ERRORS
    }
    echo
    echo
}

main(){
    # get the dockerfiles
    IFS=$'\n'
    files=( $(find . -iname '*Dockerfile' | sed 's|./||' | sort) )
    unset IFS

    ACTION=${ACTION:-dofile}
    # build all dockerfiles
    if [ -e "/usr/bin/parallel" ] || [ -e "/usr/local/bin/parallel" ]; then
        echo "Running in parallel with ${JOBS} jobs."
        parallel --tag --verbose --ungroup -j"${JOBS}" $SCRIPT $ACTION "{1}" ::: "${files[@]}"
    else
        for f in "${files[@]}"; do
            $SCRIPT $ACTION "${f}"
        done
    fi
    if [[ ! -f $ERRORS ]]; then
        echo "No errors, hooray!"
    else
        echo "[ERROR] Some images did not build correctly, see below." >&2
        echo "These images failed: $(cat $ERRORS)" >&2
        exit 1
    fi
}

run(){
    args=$@
    f=$1

    if [[ "$f" == "" ]]; then
        if [ -f "errors" ]; then
            echo "error file is still there!"
            exit 1
        fi
        main $args
    else
        $args
    fi
}

run $@
