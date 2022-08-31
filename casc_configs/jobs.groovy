job('SlackTest1'){
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
}
job('SlackTest2'){
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
}

listView("SlackTest") {
    jobs {
        name('SlackTest1')
        name('SlackTest2')
    }
    columns {
        status()
        weather()
        name()
        lastSuccess()
        lastFailure()
        lastDuration()
      }
}