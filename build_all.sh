#!/usr/bin/env bash
set -e
set -o pipefail

BRANCH_NAME="$GIT_BRANCH"
if [ -z "$BRANCH_NAME" ]; then
    BRANCH_NAME=$(git rev-parse --abbrev-ref HEAD)
fi
echo "Working on $BRANCH_NAME.."
SCRIPT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
REPO_URL="${REPO_URL:-quay.io/mabunixda}"
JOBS=${JOBS:-}

ERRORS="$(pwd)/errors"
BUILD_ARGS=${BUILD_ARGS:- --pull --no-cache}
BUILDX_BUILDER="default"
version_check="([0-9]+\.)?([0-9]+\.)?(\*|[0-9]+)"

if [ -z "$JOBS" ]; then
    if [[ $OSTYPE =~ darwin.* ]]; then
        JOBS=$(($(sysctl -n hw.ncpu) / 2))
    else
        JOBS=$(($(cat /proc/cpuinfo | grep proc | wc -l) / 2 ))}
    fi
fi

if [ "$BRANCH_NAME" == "main" ]; then
    BUILD_ARGS="$BUILD_ARGS  --push"
fi

build_and_push(){
    base=$1
    suite=$2
    build_dir=$3

    if [ -e "${build_dir}/.skip" ]; then
        return
    fi
    if [ -e "${build_dir}/buildx" ]; then
        target_builder=$(cat ${build_dir}/buildx)
        if docker buildx inspect $target_builder; then
            BUILDX_BUILDER=$target_builder
        else
            echo "cannot switch buidlx builder to $target_builder - does not exist!"
        fi
    fi
    TARGET_NAME="${base}"
    if [ -e "${base}/$suite/Dockerfile" ]; then
        TARGET_NAME="${base}/${suite}"
    fi
    set -ex
    echo "Building ${REPO_URL}/${base}:${suite} for context ${build_dir}"
    REPO_URL="${REPO_URL}" CONTAINER_NAME="${base}" TARGET_NAME="$TARGET_NAME" TAG="${suite}" docker buildx bake --progress=auto $BUILD_ARGS -f docker_bake.hcl --builder $BUILDX_BUILDER $BUILDX_BUILDER || return 1
    # on successful build, push the image
    echo "                       ---                                   "
    echo "Successfully built ${base}:${suite} with context ${build_dir}"
    echo "Successfuly pushed ${base}:${suite}"
    echo "                       ---                                   "

    mondoo_scan "${REPO_URL}/${base}:${suite}"

    if [ "$BRANCH_NAME" != "main" ]; then
        return
    fi

    # also push the tag latest for "stable" tags
    if [[ "$suite" == "stable" ]]; then
        echo "                       ---                                   "
        REPO_URL="${REPO_URL}" CONTAINER_NAME="${base}" TARGET_NAME="${TARGET_NAME}" TAG="latest" docker buildx bake --progress=plain $BUILD_ARGS -f docker_bake.hcl --builder $BUILDX_BUILDER || return 1
        echo "Successfully pushed ${base}:latest"
        echo "                       ---                                   "
    fi

    if [ "$(grep -c "VERSION=" "${build_dir}/Dockerfile")" != "0" ]; then
        container_version=$(docker inspect -f {{.Config.Labels.version}} "${REPO_URL}/${base}:latest" | grep -v "no value" || echo "")
        if [ -z "$container_version" ]; then
            container_version=$(grep " VERSION=" "${build_dir}/Dockerfile" | head -n 1 | awk -F'=' '{print $2}' || echo "")
        fi
        if [ -n "$container_version" ]; then
            echo "                       ---                                   "
            echo "found version $container_version"
            REPO_URL="${REPO_URL}" CONTAINER_NAME="${base}" TARGET_NAME="${TARGET_NAME}" TAG="${container_version}" docker buildx bake --progress=plain $BUILD_ARGS -f docker_bake.hcl --builder $BUILDX_BUILDER || return 1
            echo "Successfully pushed ${base}:${container_version}"
            echo "                       ---                                   "
        fi
    fi
    echo "done"

}

mondoo_scan() {
    container=$1
    shift

    if [ ! -f "$HOME/mondoo.json" ]; then
        return
    fi

    mondoo scan -t "docker://$container" --config "$HOME/mondoo.json" || echo ""

}

prefetch() {

    echo "Getting base images..."
    IMAGES=$(grep "^FROM " -R * | awk -F' ' '{print $2}' | grep -v "\${" | sort | uniq)
    if [ -e "/usr/bin/parallel" ] || [ -e "/usr/local/bin/parallel" ]; then
        parallel --tag --verbose --ungroup -j"${JOBS}" docker pull "{1}" ::: "${IMAGES[@]}"
    else
        for d in ${IMAGES}; do
            docker pull $d;
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
    if [ -e "/usr/bin/parallel" ] || [ -e "/usr/local/bin/parallel" ] || [ -e "/opt/homebrew/bin/parallel" ]; then
        echo "Running in parallel with ${JOBS} jobs."
        parallel --tag --verbose --ungroup -j 2 $SCRIPT $ACTION "{1}" ::: "${files[@]}"
    else
        echo "running serially"
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
