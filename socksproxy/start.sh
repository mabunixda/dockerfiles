#!/bin/sh

CMD="$1"

echo "starting ssh-agent"
eval `ssh-agent -s`

echo "adding ssh key.."
    for file in $( find ${HOME}/.ssh/ -name "id_?sa*" -not -name "*.*" ); do
    	/usr/bin/ssh-add $file;
    done

echo "generating tunnel..."
exec ${CMD}
