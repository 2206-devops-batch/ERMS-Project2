pipeline {
    agent any
    stages {
        stage('Build') {
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
        stage('Deliver') {
            steps {

                withDockerRegistry([ credentialsId: "dockerhub", url: "" ]) {
                    
                    sh  'docker push mshmsudd/flask-app:$BUILD_NUMBER'

                    echo 'Run docker container'
                    // sh "docker run -d -p 3000:3000 mshmsudd/flask-app"
                }
            }
        }
        stage('kubernetes deployment')  {
            steps {
                sh '''
                     
                    cd flask-calculator-deployment
                    kubectl apply -f k8s-flask-calculator-deployment.yml
                '''

            }
            
        }

    }
    post {
        success {
            discordSend description: "Jenkins Pipeline Build", footer: "Footer Text", link: env.BUILD_URL, result: currentBuild.currentResult, title: JOB_NAME, webhookURL: "https://discord.com/api/webhooks/993653688251977870/jBKI7wwzebBdfEymLf0hLoR3H3yYhPXuM56ZBrNEvydLeP8vzrhC2_-x2r4iHehACRmf"
        }
    }
}
