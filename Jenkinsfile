pipeline {
    agent any
    stages {
        /**stage('SonarQube analysis') {
            steps {
                withSonarQubeEnv('SonarQube') {
                    sh "sonar-scanner \
                        -Dsonar.projectKey=sonarqube-flask \
                        -Dsonar.sources=. \
                        -Dsonar.host.url=http://localhost:9000 \
                        -Dsonar.login=8f413365a32d78e21e769174c410a66097938ae0"
                }
            }
        }
        stage("Quality gate") {
            steps {
                waitForQualityGate abortPipeline: true
            }
        }*/
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
                docker build -t flask-app:1.0 .
                docker tag flask-app mshmsudd/flask-app:$BUILD_NUMBER
                '''

                echo 'Running Docker container......'
                sh '''
                docker run -p 3000:3000 --name flask-app -d flask-app
                '''
            }
        }
        stage('Deliver') {
            steps {
                echo 'Deliver....'
                sh '''
                // sudo nohup python3 app.py > log.txt 2>&1 &
                '''

                withDockerRegistry([ credentialsId: "dockerHub", url: "" ]) {
                    sh  'docker push mshmsudd/flask-app:$BUILD_NUMBER'
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