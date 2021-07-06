pipeline {
    agent any
    environment {
        registry = "registry-vpc.cn-beijing.aliyuncs.com/kubemaster/gocodecitestdemo"
        registryCredential = '854bfe2f-7923-48a5-9156-7be54cc38a88'
    }
    stages {
        stage('Cloning Git') {
            steps {
                git 'https://github.com/ZWE/zwz.com-apis.git'
            }
        }
        stage('Building image') {
            steps {
                script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }
        stage('Testing Image') {
            steps {
                sh "docker run --rm $registry:$BUILD_NUMBER"
            }
        }
        stage('Deploy Image') {
            steps {
                script {
                    docker.withRegistry('https://registry-vpc.cn-beijing.aliyuncs.com', registryCredential) {
                        dockerImage.push()
                    }
                }
            }
        }
        stage('Remove Unused docker image') {
            steps {
                sh "docker rmi $registry:$BUILD_NUMBER"
            }
        }
    }
}