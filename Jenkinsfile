pipeline {
    agent {
        docker {
            image 'node:alpine' 
            args '-p 3050:3000' 
        }
        environment {
            CI = 'true'
        }
    }
    stages {
        stage('Build') { 
            steps {
                sh 'npm install' 
            }
        }
        stage('Test') {
            steps {
                sh './jenkins/scripts/test.sh'
            }
        }
    }

}