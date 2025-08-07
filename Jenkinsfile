pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub_creds')
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/venkat69-sys/poc.git'
            }
        }
        stage('Build Images') {
            steps {
                script {
                    docker.build("venkat69-sys/backend", "./backend/")
                    docker.build("venkat69-sys/frontend", "./frontend/")
                }
            }
        }
        stage('Push Images') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io', 'dockerhub-creds') {
                        docker.image("venkat69-sys/backend").push()
                        docker.image("venkat69-sys/frontend").push()
                    }
                }
            }
        }
        stage('Deploy to Kubernetes') {
            steps {
                sh '''
                kubectl apply -f k8s/backend-deployment.yaml
                kubectl apply -f k8s/frontend-deployment.yaml
                kubectl apply -f k8s/service.yaml
                '''
            }
        }
    }
}
