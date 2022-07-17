pipeline {
    agent any
    stages {
        stage('Build') {
            steps {
                echo "Building.."
                sh '''
                git pull
                cd ERMS-Project2/flask-calculator
                pip3 install -r requirements.txt
                '''
            }
        }
        stage('Test') {
            steps {
                echo "Testing.."
                sh '''
                cd ERMS-Project2/flask-calculator
                python3 -m unittest TestCalc.py
                '''
            }
        }
        stage('Docker Build') {
            steps {
                echo 'Building docker image from Dockerfile....'
                sh '''
                cd ERMS-Project2/flask-calculator
                sudo docker build -t mshmsudd/flask-app:$BUILD_NUMBER .
                '''
            }
        }
        stage('Pushing to Docker Hub'){
            steps{
                withDockerRegistry([ credentialsId: "dockerhub", url: "" ]) {
                    sh  'docker push mshmsudd/flask-app:$BUILD_NUMBER'
                }
            }
        }
        stage('Deliver to Production') {
            when { branch 'Production'}
                // EKS push
                echo 'Running docker container on:'
                sh '''whoami
                sudo yum install docker -y
                docker pull mshmsudd/flask-app
                docker run -d -p 3000:3000 mshmsudd/flask-app'''
            }
        }
        stage('Deliver to Development') {
            when { branch 'Development'}
            steps {
                // EKS push
                echo 'Running docker container on:'
                sh '''whoami
                sudo yum install docker -y
                docker pull mshmsudd/flask-app
                docker run -d -p 3000:3000 mshmsudd/flask-app'''
            }
        }
    }
    post {
        success {
            discordSend description: "Jenkins Pipeline Build", footer: "Footer Text", link: env.BUILD_URL, result: currentBuild.currentResult, title: JOB_NAME, webhookURL: "https://discord.com/api/webhooks/993653688251977870/jBKI7wwzebBdfEymLf0hLoR3H3yYhPXuM56ZBrNEvydLeP8vzrhC2_-x2r4iHehACRmf"
        }
    }

