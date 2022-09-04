pipeline {
    agent any 
    stages {
        stage('Pipeline to seed or Update all pipelines') {
            steps {
                jobDsl  targets: ['jobs/*.groovy'].join('\n')
            }
        }
        stage('Build JNLP Node') {
            steps {
                BuildJob("node-jnlp")
            }
        }
    }
}