@Library('hps-shared-lib') _

environment {
    IMAGE_NAME  = "dummy-microservice"
    IMAGE_TAG   = "${env.BUILD_NUMBER}"
    HARBOR_URL  = "http://172.26.206.127:8888"    // ← your real IP
    HARBOR_PROJECT = "shared-lib-demo"
}

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
                pushToRegistry(IMAGE_NAME, IMAGE_TAG, HARBOR_URL, HARBOR_PROJECT)
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
