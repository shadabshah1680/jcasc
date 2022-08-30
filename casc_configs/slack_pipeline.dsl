pipelineJob('slack_shared_library_configuration_with_jcasc') {
    definition {
        cps {
            script('''
node {

    stage("STARTED") {
    
					try{
					        slackNotifier()
                  echo "STARTED"
         }
					catch(e) {
					        currentBuild.result = 'FAILURE'	
         }
					finally {
                   slackNotifier(currentBuild.result)
         }
    
    } 
       
    stage("SUCCESS") {

					try{
					        slackNotifier()
                  echo "SUCCESS"
         }
					catch(e) {
					        currentBuild.result = 'FAILURE'	
         }
					finally {
                   slackNotifier(currentBuild.result)
         }    
   }

    stage("ERROR") {
        	
					try{
					        slackNotifier()
                  echo $error
         }
					catch(e) {
					        currentBuild.result = 'FAILURE'	
         }
					finally {
                   slackNotifier(currentBuild.result)
         }
    }
}            
            ''')
            sandbox()
        }
    }
}