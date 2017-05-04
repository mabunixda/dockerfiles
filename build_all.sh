#!/bin/bash
set -e
set -o pipefail

SCRIPT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
REPO_URL="${REPO_URL:-r.nitram.at}"
JOBS=${JOBS:-2}

ERRORS="$(pwd)/errors"

build_and_push(){
	base=$1
	suite=$2
	build_dir=$3

	[ -f "${build_dir}/.skip_buiild" ] && return 0;

	echo "Building ${REPO_URL}/${base}:${suite} for context ${build_dir}"
	docker build --rm --force-rm -t ${REPO_URL}/${base}:${suite} ${build_dir} || return 1

	# on successful build, push the image
	echo "                       ---                                   "
	echo "Successfully built ${base}:${suite} with context ${build_dir}"
	echo "                       ---                                   "


	[ -f "${build_dir}/.skip_push" ] && return 0;

	# try push a few times because notary server sometimes returns 401 for
	# absolutely no reason
	n=0
	until [ $n -ge 5 ]; do
    	docker push ${REPO_URL}/${base}:${suite} && break
		echo "Try #$n failed... sleeping for 15 seconds"
		n=$[$n+1]
		sleep 15
	done

	# also push the tag latest for "stable" tags
	if [[ "$suite" == "stable" ]]; then
		docker tag ${REPO_URL}/${base}:${suite} ${REPO_URL}/${base}:latest
		docker push ${REPO_URL}/${base}:latest
	fi
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

	# build all dockerfiles
	if [ -e "/usr/bin/parallel" ]; then  
		echo "Running in parallel with ${JOBS} jobs."
		parallel --tag --verbose --ungroup -j"${JOBS}"     $SCRIPT dofile "{1}" ::: "${files[@]}"
	else
		for f in "${files[@]}"; do
			$SCRIPT dofile "${f}"
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
