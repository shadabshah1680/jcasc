pipelineJob('deploy-jnlp-nodes') {
    definition {
        cps {
            script('''

@Library('slack_alert_library@main') _
def msg = "`${env.JOB_NAME}` #${env.BUILD_NUMBER}:\\n"
def desired_capacity = "1"
def max_size = "5"
def group_name = "jnlp-lc-4"


pipeline {
    agent {
		label 'master'
	}
    stages {
        stage('Update Desired Counts') {
            steps{
				script{
	
					try{
					        slackNotifier()
					        sh 'aws autoscaling update-auto-scaling-group --auto-scaling-group-name  ${group_name}  --region us-east-1 --max-size ${max_size}'
							sh 'aws autoscaling update-auto-scaling-group --auto-scaling-group-name ${group_name} --desired-capacity ${desired_capacity} --region us-east-1'
						}
					catch(e) {
					        currentBuild.result = 'FAILURE'
					        throw e	
					
					}
					finally {
                            slackNotifier(currentBuild.result)
                           }
				 }
				    
				}
            }
        }			
    }
                ''')
            sandbox()
        }
    }
}