#!/bin/bash
newdirname="/home/ec2-user/Eurus_Docker"
newdirnames="/home/ec2-user/Eurus-Docker"
if [ -d "$newdirnames" ]; then
echo "Directory already exists";
`rm -rf $newdirnames`;
else
`mkdir -p $newdirnames`;
echo "$newdirnames directory is created"
fi

if [ -d "$newdirname" ]; then
echo "Directory already exists" ;
else
`mkdir -p $newdirname`;
echo "$newdirname directory is created"
fi
git clone https://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@github.com/shadabshah1680/Eurus-Docker.git
cp -rf /home/ec2-user/Eurus-Docker/* /home/ec2-user/Eurus_Docker
sh -xv /home/ec2-user/Eurus_Docker/Env_Var_Replace.sh
rm -rf /home/ec2-user/Eurus_Docker/Env_Var_Replace.sh

sudo docker build -t mongo:4.2.2 -f /home/ec2-user/Eurus_Docker/Mongo.dockerfile .
sleep 20
sudo docker run -d mongo:4.2.2

