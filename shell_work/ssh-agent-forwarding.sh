#!/bin/bash
#$1 is any hostname or ip
a="Host $1\n
     ForwardAgent yes"
echo -e $a >> /home/$USER/.ssh/config

#
eval "$(ssh-agent)"

#$2 is absolute path of host RSA key
ssh-add $2
