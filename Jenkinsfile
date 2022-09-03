import org.jenkinsci.plugins.scriptsecurity.scripts.ScriptApproval
ScriptApproval scriptApproval = ScriptApproval.get()
scriptApproval.pendingScripts.each {
    scriptApproval.approveScript(it.hash)
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
