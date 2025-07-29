pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/venkat69-sys/poc.git'
            }
        }

        stage('Build Docker Images') {
            steps {
                script {
                    sh 'eval $(minikube docker-env) && docker build -t backend/dockerfile'
                    sh 'eval $(minikube docker-env) && docker build -t frontend/dockerfile'
                }
            }
        }
    }

    post {
        success {
            echo 'Deployment completed successfully!'
        }
        failure {
            echo 'Deployment failed.'
        }
    }
}
