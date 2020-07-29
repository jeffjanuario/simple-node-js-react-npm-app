pipeline {
    def userInput = true
    def didTimeout = false
    try {
        timeout(time: 15, unit: 'SECONDS') { // change to a convenient timeout for you
            userInput = input(
            id: 'Proceed1', message: 'Was this successful?', parameters: [
             [$class: 'BooleanParameterDefinition', defaultValue: true, description: '', name: 'Please confirm you agree with this']
            ])
        }
    } catch(err) { // timeout reached or input false
        def user = err.getCauses()[0].getUser()
        if('SYSTEM' == user.toString()) { // SYSTEM means timeout.
            didTimeout = true
        } else {
            userInput = false
            echo "Aborted by: [${user}]"
        }
    }

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
                if (didTimeout) {
                    echo "no input was received before timeout"
                    sh './jenkins/scripts/kill.sh' 
                } else if (userInput == true) {
                    echo "this was successful"
                    sh './jenkins/scripts/kill.sh' 
                } else {
                    echo "this was not successful"
                    currentBuild.result = 'FAILURE'
                } 
            }
        }
    }
}
