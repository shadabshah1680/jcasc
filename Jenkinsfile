pipeline {
    agent any
    stages {
        stage('SCM') {
            steps {
                sh "git clone -b main git@github.com:shadabshah1680/Eurus_Work.git"
            }
        }
    }
    post { 
        always { 
            cleanWs()
        }
    }
}
