#!/bin/bash
#--------Set Region--------#

aws configure set region us-east-1

#--------Get parameter Values--------#

ROOT_USER_NAME=$(aws ssm get-parameter --name "db_root_username" --query 'Parameter.Value' --region us-east-1 --with-decryption --output text 2>&1 | sed 's/.*----BEGIN/----BEGIN/')
ROOT_PASS_WORD=$(aws ssm get-parameter --name "db_root_password" --query 'Parameter.Value' --region us-east-1 --with-decryption --output text 2>&1 | sed 's/.*----BEGIN/----BEGIN/')
APPLICATION_DATA_BASE=$(aws ssm get-parameter --name "db_app_database" --query 'Parameter.Value' --region us-east-1 --with-decryption --output text 2>&1 | sed 's/.*----BEGIN/----BEGIN/')
APPLICATION_USER_NAME=$(aws ssm get-parameter --name "db_app_username" --query 'Parameter.Value' --region us-east-1 --with-decryption --output text 2>&1 | sed 's/.*----BEGIN/----BEGIN/')
APPLICATION_PASS_WORD=$(aws ssm get-parameter --name "db_app_password" --query 'Parameter.Value' --region us-east-1 --with-decryption --output text 2>&1 | sed 's/.*----BEGIN/----BEGIN/')

#--------Replace Variables-------#

sed -i "s|ROOT_USER_NAME|${ROOT_USER_NAME}|g" /home/ec2-user/Eurus_Docker/set_mongodb_password.sh
sed -i "s|ROOT_PASS_WORD|${ROOT_PASS_WORD}|g" /home/ec2-user/Eurus_Docker/set_mongodb_password.sh
sed -i "s|APPLICATION_DATA_BASE|${APPLICATION_DATA_BASE}|g" /home/ec2-user/Eurus_Docker/set_mongodb_password.sh
sed -i "s|APPLICATION_USER_NAME|${APPLICATION_USER_NAME}|g" /home/ec2-user/Eurus_Docker/set_mongodb_password.sh
sed -i "s|APPLICATION_PASS_WORD|${APPLICATION_PASS_WORD}|g" /home/ec2-user/Eurus_Docker/set_mongodb_password.sh