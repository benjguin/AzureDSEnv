#!/bin/bash

#this is a sample script that runs after the VM has started, the first time
#the following is just an example


message="this message was written by setup1VMScript.sh on `date --rfc-2822`"
cat >> ~/setup1VMscript.txt << EOF
$message
EOF
sudo cp ~/setup1VMscript.txt /root/
