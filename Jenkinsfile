pipeline {
    agent any 
    stages {
        stage('Pipeline to seed or Update all pipelines') {
            steps {
                jobDsl  targets: ['jobs/*.groovy'].join('\n')
            }
        }
        stage('Deploy to Production'){
                steps{
                    timeout(time:5, unit:'DAYS'){
                        input message:'Approve PRODUCTION Deployment?'
                    }
                    build job: 'slack_shared_library_configuration_with_jcasc'
                }
            }
    }
}