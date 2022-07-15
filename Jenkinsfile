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
        stage('Deliver to Production') {
            when { branch 'Production'}
        
        }


        stage('Deliver to Development') {
            when { branch 'Development'}
        }
            steps {

                withDockerRegistry([ credentialsId: "dockerhub", url: "" ]) {
                    // This needs the EKS command for deployment.
                    sh  'docker push mshmsudd/flask-app:$BUILD_NUMBER'

                    echo 'Run docker container'
                    sh "docker run -d -p 3000:3000 mshmsudd/flask-app"
                }
            }
        }
        stage('Deliver to Development') {
            steps {
                
                withDockerRegistry([ credentialsId: "dockerhub", url: "" ]) {
                    
                    sh  'docker push mshmsudd/flask-app:$BUILD_NUMBER'
                    //Maybe separate these steps?
                    echo 'Run docker container'
                    sh "docker run -d -p 3000:3000 mshmsudd/flask-app"
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