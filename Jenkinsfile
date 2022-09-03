def scriptApproval = org.jenkinsci.plugins.scriptsecurity.scripts.ScriptApproval.get()

String[] signs = [
    "method org.jenkinsci.plugins.workflow.steps.FlowInterruptedException getCauses",
    "method org.jenkinsci.plugins.workflow.support.steps.input.Rejection getUser"
    ]

for( String sign : signs ) {
    scriptApproval.approveSignature(sign)
}

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
