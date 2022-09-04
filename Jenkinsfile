pipeline {
    agent any 
    stages {
        stage('Pipeline to seed or Update all pipelines') {
            steps {
                jobDsl  targets: ['jobs/*.groovy'].join('\n')
            }
        }
        stage('Build JNLP Node') {
            steps {
                build("node-jnlp")
            }
        }
        stage('Build prod_cfn_stack') {
            steps {
                build("prod_cfn_stack")
            }
        }
        stage('Build Slack test Job') {
            steps {
                build("prod_slack_shared_library_configuration_with_jcasc")
            }
        }        
    }
}