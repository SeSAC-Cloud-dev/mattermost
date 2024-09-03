pipeline {
    agent any

    tools {
        git "git"
        nodejs "nodejs-20.16.0"
    }

    environment{
        AWS_ACCOUNT_ID = "214346124741"
        IMAGE_NAME = "cloudnexus/mattermost"
        ECR_REPO = "${AWS_ACCOUNT_ID}.dkr.ecr.ap-northeast-2.amazonaws.com/${IMAGE_NAME}"
    }

    stages {
        stage("git clone") {
            steps {
                git branch: "master", url: "https://github.com/SeSAC-Cloud-dev/mattermost", credentialsId: "github"
            }
        }

        stage("build") {
            steps {
                dir("server") {
                    sh 'make build && make package'
                }
            }
        }

        stage("build docker image") {
            steps {
                sh 'docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} .'
            }
        }

        stage("AWS ECR login") {
            steps {
                sh 'aws ecr get-login-password --region ap-northeast-2 | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.ap-northeast-2.amazonaws.com'
            }
        }
        
        stage("Publish Docker Image") {
            steps {
                sh 'docker tag ${IMAGE_NAME}:${BUILD_NUMBER} ${ECR_REPO}:${BUILD_NUMBER}'
                sh 'docker push ${ECR_REPO}:${BUILD_NUMBER}'
            }
        }

        stage("clean") {
            steps {
                sh 'docker image rm ${IMAGE_NAME}:${BUILD_NUMBER} ${ECR_REPO}:${BUILD_NUMBER}'
            }
        }
    }
}
