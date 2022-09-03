def signature = 'new groovy.json.JsonSlurperClassic'
org.jenkinsci.plugins.scriptsecurity.scripts.ScriptApproval.get().approveSignature(signature)
pipeline {
    agent any 
    stages {
        stage('Pipeline to seed or Update all pipelines') {
            steps {
                jobDsl  targets: ['jobs/*.groovy'].join('\n')
            }
        }

        // stage('Build Slack Test Job'){
        //         steps{
        //             build job: 'slack_shared_library_configuration_with_jcasc'
        //             }
        //         }
        }
    }
