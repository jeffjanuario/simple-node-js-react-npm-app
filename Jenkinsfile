pipeline {
    agent {
        docker {
            image 'node:6-alpine'
            args '-p 3000:3000'
        }
    }
    environment { 
        CI = 'true'
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
        stage('Deliver') { 
            steps {
                sh './jenkins/scripts/deliver.sh' 
                script {
                   def userInput
                    timeout(time: 60, unit: 'SECONDS') {
                        println 'Waiting for input'
                        userInput = input id: 'CustomId', message: 'Want to continue?', ok: 'Yes', parameters: [string(defaultValue: 'world', description: '', name: 'hello'), string(defaultValue: '', description: '', name: 'token')]
                    }
                }
                sh './jenkins/scripts/kill.sh' 
            }
        }
    }
}
