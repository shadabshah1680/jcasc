pipelineJob('prod_slack_shared_library_configuration_with_jcasc') {
    definition {
        cps {
            script('''

node {

    stage("STARTED") {
    
					try{
					        slackNotifier('STARTED')
                  echo "STARTED"
         }
					catch(a) {
					        currentBuild.result = 'FAILURE'	
         }
    
    } 
       
    stage("SUCCESS") {

					try{
					        slackNotifier('SUCCESS')
                  echo "SUCCESS"
         }
					catch(b) {
					        currentBuild.result = 'FAILURE'	
         }
			    
   }

    stage("ERROR") {
        	
					try{
					        slackNotifier('UNSTABLE')
                  echo 'ERROR'
         }
					catch(c) {
					        currentBuild.result = 'FAILURE'	
         }
    }
}
            ''')
            sandbox()
        }
    }
}


