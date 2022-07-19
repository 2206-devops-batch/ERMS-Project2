pipeline {
    environment {
        registry = "mshmsudd/blue-green-flask-app"
        registryCredential = 'dockerhub'
    }
    agent any
    stages {
        stage('Environment Test') {
            steps{
                sh 'echo "eksctl version $(eksctl version)"'
                sh 'echo "docker version $(docker --version)"'
                sh 'echo "kubectl version $(kubectl version --short --client)"'
                // sh 'echo "Hadolint version $(hadolint --version)"'
            }
        }
        stage('build image'){
            parallel{
                stage('Build Blue App Image'){
                    steps{
                        sh 'echo " building blue app docker image"'
                        sh "chmod +x -R ${env.WORKSPACE}"
                        sh 'cd blue_app && ./run_docker.sh'
                    }
                }
                stage('Build Green App Image'){
                    steps{
                        sh 'echo "building green app image"'
                        sh "chmod +x -R ${env.WORKSPACE}"
                        sh 'cd green_app && ./run_docker.sh'
                    }
                }
            }

	    }
        stage('Push image to DockerHub'){
            parallel{
                stage('Push Blue App Image'){
                    steps {
                        withDockerRegistry([ credentialsId: "dockerhub", url: "" ]) {
                            sh 'echo " push blueapp image to dockerhub"'
                            sh 'cd blue_app && ./upload_docker.sh'
                        }
                    }
                }
                stage('Push Green App Image'){
                    steps {
                        withDockerRegistry([ credentialsId: "dockerhub", url: "" ]) {
                            sh 'echo " push green app image to dockerhub"'
                            sh 'cd green_app && ./upload_docker.sh'
                        }
                    }
                }
            }
        }
        stage('Deploy Image to AWS Eks cluster'){
            parallel {
                stage('Deploy Blue App Image'){
                    steps {
			            withAWS(region:'us-east-2',credentials:'aws-cred'){
                        sh 'echo "deploy blueapp image"'
                        sh 'cd blue_app && ./run_kubernetes.sh'
			}
                    }
                }
                stage('Deploy Green App Image'){
                    steps {
			            withAWS(region:'us-east-2',credentials:'aws-cred'){
                        sh 'echo "deploy greenapp image"'
                        sh 'cd green_app && ./run_kubernetes.sh'
			}
                    }
                }
            }

	    }
        stage('Deploy load balancer Service'){
            steps {
		        withAWS(region:'us-east-2',credentials:'aws-cred'){
                sh 'echo "run load balancer service"'
                sh './run_kubernetes.sh'
		        }
            }
        }
        stage("Cleaning up") {
            steps{
                sh 'echo "Cleaning up..."'
                sh 'docker system prune --force'
            }
         }
        

    }
    post {
        success {
            discordSend description: "ERMS Jenkins CI/CD Pipeline", footer: "Footer Text", link: env.BUILD_URL, result: currentBuild.currentResult, title: JOB_NAME, webhookURL: "https://discord.com/api/webhooks/993653688251977870/jBKI7wwzebBdfEymLf0hLoR3H3yYhPXuM56ZBrNEvydLeP8vzrhC2_-x2r4iHehACRmf"
        }
    }
}
