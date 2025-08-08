pipeline {
    agent any
    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-creds')
        kubectl apply --kubeconfig=/var/lib/jenkins/.kube/config
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
                    docker.build("69venkat/backend", "./backend/")
                    docker.build("69venkat/frontend", "./frontend/")
                }
            }
        }
        stage('Push Images') {
            steps {
                script {
                    docker.withRegistry('https://index.docker.io', 'dockerhub-creds') {
                        docker.image("69venkat/backend").tag("latest")
                        docker.image("69venkat/frontend").tag("latest")
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
