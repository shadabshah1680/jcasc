pipeline {
    agent any 
    stages {
        stage('Pipeline to seed or Update all pipelines') {
            steps {
                jobDsl  targets: ['jobs/*.groovy'].join('\n')
                ignoreExisting(false)
                removeAction('DELETE')
                removeViewAction('DELETE')
                lookupStrategy('SEED_JOB')
	
            }
        }
    }
}