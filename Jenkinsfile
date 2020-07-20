pipeline {
    agent {
        docker {
            image 'node:alpine' 
            args '-p 3050:3000' 
        }
    }
    stages {
        stage('Build') { 
            steps {
                sh 'npm install' 
            }
        }
    }
}