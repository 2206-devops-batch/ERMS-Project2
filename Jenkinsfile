pipeline {
    agent any
    stages {
        stage('Build') {
            agent any
            steps {
                dir("flask-calculator"){
                    echo 'Building Flask-Calculator'
                    sh 'pip3 install -r requirements.txt'
                }
            }
        }
        stage('Test') {
            steps {
                dir("flask-calculator"){
                    echo 'Testing Flask'
                    sh 'python3 -m unittest TestCalc.py'
                }
            }
        }
        stage('Docker Build') {
            steps {
                dir("flask-calculator"){
                    echo 'Building docker image from Dockerfile....'
                    sh 'sudo docker login -u ${DOCK_USER} --password-stdin ${DOCK_PASSWORD}'
                    sh 'sudo docker build /home/ec2-user/workspace/ERMS-Project2 -t caerbear/revature'
                }
            }
        }
        stage('Pushing to Docker Hub'){
            steps{
                sh 'sudo docker push caerbear/revature'
                sh 'sudo docker prune -af'
            }
        }
        stage('Deliver to Production') {
            when { branch 'Production'}
                steps{
                    sh 'kubectl exec whoami'
                    sh 'kubectl apply -f bb.yaml'
                }

        }
        stage('Deliver to Development') {
            when { branch 'Development'}
            steps {
                // EKS push
                sh 'kubectl exec whoami'
                sh 'kubectl apply -f bb.yaml'
            }
        }
    }
    // post {
    //     success {
    //         discordSend description: "Jenkins Pipeline Build", footer: "Footer Text", link: env.BUILD_URL, result: currentBuild.currentResult, title: JOB_NAME, webhookURL: "https://discord.com/api/webhooks/993653688251977870/jBKI7wwzebBdfEymLf0hLoR3H3yYhPXuM56ZBrNEvydLeP8vzrhC2_-x2r4iHehACRmf"
    //     }
    // }

}