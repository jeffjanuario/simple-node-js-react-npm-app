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
                def userInput
                timeout(time: 10, unit: 'SECONDS') {
                    userInput = input id: 'messageDeliver', message: 'Finished using the web site? (Click "Proceed" to continue)?', ok: 'Yes', 
                    parameters: [string(defaultValue: 'yes', description: '', name = ''), string(defaultValue: '', description: '', name: '')]
                }
                sh './jenkins/scripts/kill.sh' 
            }
        }
    }
}
