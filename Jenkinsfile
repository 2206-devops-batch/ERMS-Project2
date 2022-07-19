pipeline {
    agent any
    stages {
        stage('Building') {
            steps {
                echo "Building.."
                sh '''
                cd flask-calculator
                pip3 install -r requirements.txt
                '''
            }
        }
        stage('Test') {
            steps {
                echo "Testing.."
                sh '''
                cd flask-calculator
                python3 -m unittest TestCalc.py
                '''
            }
        }
        stage('Docker Build') {
            steps {
                echo 'Building docker image from Dockerfile....'
                sh '''
                cd flask-calculator
                docker build -t mshmsudd/flask-app:$BUILD_NUMBER .
                '''
            }
        }
        // stage('Deliver') {
        //     steps {
        //         sh  'docker push mshmsudd/flask-app:$BUILD_NUMBER'
        //     }
        // }
        stage('blue kubernetes deployment')  {
            steps {
                withCredentials([aws(accessKeyVariable: 'AWS_ACCESS_KEY_ID', credentialsId: 'aws-cred', secretKeyVariable: 'AWS_SECRET_ACCESS_KEY')]) {
                    sh '''
                        sh 'curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl'  
                        sh 'chmod u+x ./kubectl'  
                        sh './kubectl get pods'
                        kubectl apply -f jenkins-blue-service.yml
                    '''
                }
            }
        }
    }
    post {
        success {
            discordSend description: "Jenkins Pipeline Build", footer: "Footer Text", link: env.BUILD_URL, result: currentBuild.currentResult, title: JOB_NAME, webhookURL: "https://discord.com/api/webhooks/993653688251977870/jBKI7wwzebBdfEymLf0hLoR3H3yYhPXuM56ZBrNEvydLeP8vzrhC2_-x2r4iHehACRmf"
        }
    }
}
