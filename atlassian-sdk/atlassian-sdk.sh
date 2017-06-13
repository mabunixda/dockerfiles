#!/bin/bash

SDK_PATH=$(ls -d /usr/share/atlassian-plugin-sdk*)
MAVEN_PATH=$(ls -d $SDK_PATH/*maven*)
export PATH="$PATH:$MAVEN_PATH/bin:$SDK_PATH/bin"
