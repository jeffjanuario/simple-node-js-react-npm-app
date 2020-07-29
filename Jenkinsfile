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
            }
        }
        stage ('Wait') {
            options {
                timeout(time: 3, unit: "SECONDS")
            }
            steps {
                input message: 'Finished using the web site? (Click "Proceed" to continue)', ok: 'Yes' 
                catchError(buildResult: 'SUCCESS', stageResult: 'SUCCESS') { 
                    echo "Started stage wait"
                }
            }
        }
        stage ('Kill'){
            steps {
                sh './jenkins/scripts/kill.sh' 
            }
        }
    }
}
