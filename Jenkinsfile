@Library('hps-shared-lib') _

pipeline {
    agent any

    environment {
        IMAGE_NAME = "dummy-microservice"
        IMAGE_TAG  = "${env.BUILD_NUMBER}"
    }

    stages {
        stage('Checkout') {
            steps {
                echo "Code checked out by Jenkins automatically"
            }
        }

        stage('Build') {
            steps {
                sh "echo 'Simulating mvn package'"
            }
        }

        stage('Test') {
            steps {
                sh "echo 'Simulating mvn test'"
            }
        }

        stage('SonarQube') {
            steps {
                sonarScan()
            }
        }

        stage('Docker Build') {
            steps {
                dockerBuild(IMAGE_NAME, IMAGE_TAG)
            }
        }

        stage('Trivy Scan') {
            steps {
                trivyScan(IMAGE_NAME, IMAGE_TAG)
            }
        }

        stage('Push') {
            steps {
                pushToRegistry(IMAGE_NAME, IMAGE_TAG)
            }
        }

        stage('Deploy') {
            steps {
                helmDeploy(IMAGE_NAME, 'production')
            }
        }
    }

    post {
        success {
            echo "Pipeline SUCCESS - Build #${env.BUILD_NUMBER}"
        }
        failure {
            echo "Pipeline FAILED - Build #${env.BUILD_NUMBER}"
        }
    }
}
