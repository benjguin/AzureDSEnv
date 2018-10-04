#!/bin/bash

#this is a sample script that runs after the VM has started, the first time
#the following is just an example


message="this message was written by sampleScript.sh on `date --rfc-2822` by `whoami` from `pwd`"
cat >> ~/sampleScriptOutput.txt << EOF
$message
EOF
