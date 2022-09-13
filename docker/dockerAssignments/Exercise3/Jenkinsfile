def notifySlack(String buildStatus = 'STARTED') {
    // Build status of null means success.
    buildStatus = buildStatus ?: 'SUCCESS'

    def color

    if (buildStatus == 'STARTED') {
        color = '#00FF00'
    } else if (buildStatus == 'SUCCESS') {
        color = '#00FF00'
    } else if (buildStatus == 'UNSTABLE') {
        color = '#ff0000'
    } else {
        color = '#ff0000'
    }

    def msg = "${buildStatus}: `${env.JOB_NAME}` #${env.BUILD_NUMBER}:\n${env.BUILD_URL}"

    slackSend(color: color, message: msg)
}

node {
    try {
        notifySlack()

        // Existing build steps.
    } catch (e) {
        currentBuild.result = 'FAILURE'
        throw e
    } finally {
        notifySlack(currentBuild.result)
    }
}

////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////


pipeline {
    agent any
    stages {
        stage('SCM') {
            steps {
                sh "git clone -b docker-exerciseTwo git@github.com:shadabshah1680/Eurus_Work.git"
            }
        }
        stage('Build') {
            
            steps {
                sh "cd docker/dockerAssignments/Exercise2 && sudo docker build -t shadabshah1680/dockerhub:latest -f first.Dockerfile ."
            }
        }
        stage('Demo Deploy') {
            
            steps {

                sh "sudo docker run shadabshah1680/dockerhub:latest --version"        
            }
        }
        stage('Push To Dockerhub') {
            
            steps {
                sh "sudo docker login -u shadabshah1680 -p shadabshah"
                sh "sudo docker push shadabshah1680/dockerhub:latest"
            }
        }
    }
    post {
       // trigger every-works
       always {
        
            cleanWs()
       }
    }
}
