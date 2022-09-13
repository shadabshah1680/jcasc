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
                sh "cd docker/dockerAssignments/Exercise2 && sudo docker build -t docker-alpine -f dind.Dockerfile ."
            }
        }
        stage('Demo Deploy') {
            
            steps {

                sh "sudo docker run -it -v '/var/run/docker.sock:/var/run/docker.sock:rw' docker-alpine:latest /bin/sh | docker run -d -p 80:80 nginx &"        
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
