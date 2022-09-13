#!/bin/bash
aws s3 sync /var/lib/jenkins/workspace/CloudFormation_Stack_blogs_v1/Eurus_Work/aws/cloudformation/CFstackAssignment/nested-stack-v3 s3://nested-stack-101
stackname=blog-dev
aws cloudformation describe-stacks --stack-name $stackname
if [ $? -eq '255' ]; then
   aws cloudformation create-stack \
--template-url  https://nested-stack-101.s3.us-west-1.amazonaws.com/Root_Stack.yaml \
--stack-name $stackname  \
--region us-east-2 --role-arn arn:aws:iam::155965589397:role/CloudFormation_EC2_VPC_ROLE \
--capabilities CAPABILITY_IAM
else
aws cloudformation update-stack \
--template-url  https://nested-stack-101.s3.us-west-1.amazonaws.com/Root_Stack.yaml \
--stack-name $stackname  \
--region us-east-2 --role-arn arn:aws:iam::155965589397:role/CloudFormation_EC2_VPC_ROLE \
--capabilities CAPABILITY_IAM 
fi


#------------------------------------------------------------

environment {
    stackname     = "blog-dev"
    exec_role_arn = credentials('exec_role_arn') 
    template_url = credentials('template_url')
}

pipeline {
    agent any
    stages {
        stage('Build') {
            
            steps {
                sh "aws s3 sync /var/lib/jenkins/workspace/CloudFormation_Stack_blogs_v1_declarative/aws/cloudformation/CFstackAssignment/nested-stack-v3 s3://nested-stack-101"
            }
        }
        stage('Deploy') {
            
            steps {
                script {
                try {
                    sh "aws cloudformation update-stack --template-url  ${template_url} --stack-name ${stackname} --region us-east-2 --role-arn ${exec_role_arn} --capabilities CAPABILITY_IAM"
                  }
                catch (Exception e) {
                    sh "aws cloudformation create-stack --template-url  ${template_url} --stack-name ${stackname} --region us-east-2 --role-arn ${exec_role_arn} --capabilities CAPABILITY_IAM"
                }
		   }    
        }
    }
    stage('CleanWS'){
      steps {
        cleanWs()
      }
    }  
  }
}



