pipeline {
    agent any

    environment {
        IMAGE_BACKEND = "devops-backend:local"
        IMAGE_FRONTEND = "devops-frontend:local"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/venkat69-sys/poc.git'
            }
        }

        stage('Build Docker Images') {
            steps {
                script {
                    // Use Minikube's Docker daemon
                    sh 'eval $(minikube docker-env) && docker build -t $IMAGE_BACKEND ./backend'
                    sh 'eval $(minikube docker-env) && docker build -t $IMAGE_FRONTEND ./frontend'
                }
            }
        }

        stage('Deploy to Kubernetes') {
            steps {
                script {
                    sh '''
                        export KUBECONFIG=/var/lib/jenkins/.kube/config
                        kubectl apply -f k8s/backend-deployment.yaml
                        kubectl apply -f k8s/frontend-deployment.yaml
                        kubectl apply -f k8s/service.yaml
                    '''
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
