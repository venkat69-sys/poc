pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
    }
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/venkat69-sys/poc.git'
            }
        }

        stage('Docker Login') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    sh '''
                        echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                    '''
                }
            }
        }
        stage('Build Images') {
            steps {
                script {
                    docker.build("venkat69-sys/poc/backend", "./backend/")
                    docker.build("venkat69-sys/poc/frontend", "./frontend/")
                }
            }
        }
        stage('Push Images') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io', 'dockerhub-creds') {
                        docker.image("69venkat/backend").push()
                        docker.image("69venkat69/frontend").push()
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
