pipeline {

    agent any

    stages {
        stage('Clone Repo') {
            steps {
                git url: 'https://github.com/your/repo.git', branch: 'main'
            }
        }
        stage('Access Subfolder') {

            steps {
                dir('sonarqube_setup') {
                    sh '''
                    cd poc/sonarqube_setup/
                    install_sonarqube.sh
                    sonarqube.propertiess
                    sonarqube.service

                    '''


                }
            }
        }
    }
}
