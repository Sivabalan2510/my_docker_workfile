pipeline {
    agent any
    stages {
        stage('Clone') {
            steps {
                echo 'Cloning the repository...'
                git url: 'https://github.com/Sivabalan2510/my_docker_workfile', credentialsId: 'Sivabalan2510'
            }
        }
        stage('Build') {
            steps {
                echo 'Building the project...'
                // Add your build commands here, e.g., mvn clean install for a Maven project
            }
        }
        stage('Test') {
            steps {
                echo 'Running tests...'
                // Add your test commands here
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying the application...'
                // Add your deployment commands here
            }
        }
    }
}
