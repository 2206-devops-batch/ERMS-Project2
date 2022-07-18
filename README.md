<!-- PROJECT SHIELDS -->
[![Contributors][contributors-shield]][contributors-url]
[![Forks][forks-shield]][forks-url]
[![Stargazers][stars-shield]][stars-url]
[![Issues][issues-shield]][issues-url]
[![MIT License][license-shield]][license-url]

<!-- PROJECT TITLE -->
<div align="center">
  <h3 align="center">Project 2</h3>
</div>



<!-- TABLE OF CONTENTS -->
<div align="center">
  <details>
    <summary>Table of Contents</summary>
    <ol>
      <li><a href="#about-the-project">About The Project</a></li>
      <li><a href="#built-with">Built With</a></li>
      <li><a href="#getting-started">Getting Started</a></li>
      <li><a href="#prerequisites">Prerequisites</a></li>
      <li><a href="#installation">Installation</a></li>
      <li><a href="#usage">Usage</a></li>
      <li><a href="#roadmap">Roadmap</a></li>
      <li><a href="#contributing">Contributing</a></li>
      <li><a href="#license">License</a></li>
      <li><a href="#contact">Contact</a></li>
      <li><a href="#acknowledgments">Acknowledgments</a></li>
    </ol>
  </details>
</div>


<!-- ABOUT THE PROJECT -->
## About The Project

[![Product Name Screen Shot][product-screenshot]](https://github.com/2206-devops-batch/ERMS-Project2/blob/master/images/screenshot.PNG)

Key Concepts:
* This project uses a CI/CD pipeline which extensively focuses on code quality.
* This project leverages the power of ec2(s) and EKS to support the long-term viability of the deployment.
* This project has a blue/green deployment strategy which focuses on a clean, clear, and consistent user experience without hindering development.

This project listens to a webhook from github, sent on push(es) to an Amazon Web Services (AWS) Elastic Compute Cloud (ec2) instance. This t2.medium ec2 instance runs Jenkins which controls a devops pipeline. The t2.medium was necessary for the overall health of the Jenkins instance, whereas the cheaper t2.micros can often hang on pipeline operations and become unreachable. This Jenkins pipeline runs a series of built-in tests, including Sonarqube code linting, code smells, vulnerability scans, and bug analyses. Jenkins then builds a docker image of the project and pushes it to Docker Hub. This pipeline then creates a deployment, ingress, and service to a remote Elastic Kubernetes Service (EKS) cluster through a single YAML file. To recreate this, your own EKS instance's credentials need to be properly provisioned for a service account in AWS Identity and Access Management (IAM) roles & users (eks* and cloudaccess* are recommended for creation + deployment configurations like ours). Finally, the code is deployed in a blue/green fashion, meaning that by changing the deployment but not the service and ingress we can change the outward appearance of our app while having very different internal functions.

We have submitted this project as part of our Revature training for group project 2.

<p align="right">(<a href="#top">back to top</a>)</p>



### Built With

* [![Docker][Docker.com]][Docker-url]
* [![DockerHub][DockerHub.com]][DockerHub-url]
* [![Jenkins][Jenkins.io]][Jenkins-url]
* [![GitHub][GitHub.com]][GitHub-url]
* [![Kubernetes][Kubernetes.io]][Kubernetes-url]

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- GETTING STARTED -->
## Getting Started & Assumptions

Be ready to spend a few dollars on this project (we spent around $20 between the four of us). This **requires paid services** from AWS. There are ways to build this without them, but we opted for this path to be better prepared for our future working environments.

In the following Prerequisites and Installation sections we have the following assumptions:
* The developer understands how to run commands in Amazon Linux 2 (more generally red hat/CentOS)
* The developer (you) can get an ec2 up and running without aid. If not there is an excellent tutorial at: https://www.jenkins.io/doc/tutorials/tutorial-for-installing-jenkins-on-AWS/
* The developer has a functional understanding of kubernetes loadbalancer/nodeport/ingress

### Prerequisites

Once your ec2 instance (t2.medium) is up and running, this sequence of commands will install jenkins and java-openjdk11:
* npm
  ```sh
  sudo yum update –y
  sudo wget -O /etc/yum.repos.d/jenkins.repo \
    https://pkg.jenkins.io/redhat-stable/jenkins.repo
  sudo rpm --import https://pkg.jenkins.io/redhat-stable/jenkins.io.key
  sudo yum upgrade
  sudo amazon-linux-extras install java-openjdk11 -y
  sudo yum install jenkins -y
  sudo systemctl enable jenkins
  sudo systemctl start jenkins
  ```

Next we will install git:
  ```sh
  sudo yum install git -y
  ```

Now we install docker, and give jenkins permission to use it:
  ```sh
  sudo yum install docker -y
  sudo usermod -a -G docker jenkins
  ```

### Installation

The user account permissions used were maximal to get the target setup. Please don't use these in production, the authors intended use case is exclusively for minimum viable product (MVP) setup only.

1. Create a new user in your AWS IAM dashboard, and select a JSON permissions policy. The policy below contains the _maximum permissions_ necessary for this task. Use them at your own risk (please secure your instances).
   ```json
  {
      "Version": "2012-10-17",
      "Statement": [
          {
              "Sid": "eks_administrator",
              "Effect": "Allow",
              "Action": [
                  "eks:*"
              ],
              "Resource": "*"
          },
          {
              "Sid": "cloudformation_administrator",
              "Effect": "Allow",
              "Action": [
                  "cloudformation:*"
              ],
              "Resource": "*"
          }
      ]
  }
   ```

2. Set this repository up with a webhook of your jenkins url with the addition of '/github-webhook/'. If you've never done it before we found a good tutorial here: https://hevodata.com/learn/jenkins-github-webhook/

3. On your AWS IAM dashboard navigate to the user you set up with the custom JSON access policy in step 1 above. Then, in that user's section entitled 'security credentials', click 'create access key'. This will generate a key specific to this user for this use case. Do not lose it, and keep it somewhere safe.

4. SSH back into your jenkins instance and in the command line, type 'aws configure'. In the following fields, fill in the user account we just created access keys for above in step 3. This will give your instance permissions to access and remote into your soon-to-exist EKS cluster.

5. Finally, create your EKS cluster using the following commands from the command line of the ec2 instance that jenkins is running on. 
   ```sh
  eksctl create cluster --name ERMS-project2 --version 1.22 --region us-east-2 --nodegroup-name linux-nodes --node-type t2.micro --nodes 1
  aws eks --region us-east-2 update-kubeconfig --name ERMS-project2
  kubectl get all
   ```

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- USAGE EXAMPLES -->
## Usage

Use this space to show useful examples of how a project can be used. Additional screenshots, code examples and demos work well in this space. You may also link to more resources.

_For more examples, please refer to the [Documentation](https://example.com)_

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- ROADMAP -->
## Roadmap

- [x] Add Changelog
- [x] Add back to top links
- [ ] Add Additional Templates w/ Examples
- [ ] Add "components" document to easily copy & paste sections of the readme
- [ ] Multi-language Support
    - [ ] Chinese
    - [ ] Spanish

See the [open issues](https://github.com/othneildrew/Best-README-Template/issues) for a full list of proposed features (and known issues).

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

If you have a suggestion that would make this better, please fork the repo and create a pull request. You can also simply open an issue with the tag "enhancement".
Don't forget to give the project a star! Thanks again!

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- LICENSE -->
## License

Distributed under the MIT License. See `LICENSE.txt` for more information.

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- CONTACT -->
## Contact

Your Name - [@your_twitter](https://twitter.com/your_username) - email@example.com

Project Link: [https://github.com/your_username/repo_name](https://github.com/your_username/repo_name)

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- ACKNOWLEDGMENTS -->
## Acknowledgments

Use this space to list resources you find helpful and would like to give credit to. I've included a few of my favorites to kick things off!

* [Choose an Open Source License](https://choosealicense.com)
* [GitHub Emoji Cheat Sheet](https://www.webpagefx.com/tools/emoji-cheat-sheet)
* [Malven's Flexbox Cheatsheet](https://flexbox.malven.co/)
* [Malven's Grid Cheatsheet](https://grid.malven.co/)
* [Img Shields](https://shields.io)
* [GitHub Pages](https://pages.github.com)
* [Font Awesome](https://fontawesome.com)
* [React Icons](https://react-icons.github.io/react-icons/search)

<p align="right">(<a href="#top">back to top</a>)</p>



<!-- MARKDOWN LINKS & IMAGES -->
<!-- https://www.markdownguide.org/basic-syntax/#reference-style-links -->
[contributors-shield]: https://img.shields.io/github/contributors/2206-devops-batch/ERMS-Project2?style=for-the-badge
[contributors-url]: https://github.com/2206-devops-batch/ERMS-Project2/graphs/contributors
[forks-shield]: https://img.shields.io/github/forks/2206-devops-batch/ERMS-Project2?style=for-the-badge
[forks-url]:https://github.com/2206-devops-batch/ERMS-Project2.git
[stars-shield]: https://img.shields.io/github/stars/2206-devops-batch/ERMS-Project2?style=for-the-badge
[stars-url]: https://github.com/2206-devops-batch/ERMS-Project2/stargazers
[issues-shield]: https://img.shields.io/github/issues/2206-devops-batch/ERMS-Project2?style=for-the-badge
[issues-url]: https://github.com/2206-devops-batch/ERMS-Project2/issues
[license-shield]: https://img.shields.io/github/license/2206-devops-batch/ERMS-Project2?style=for-the-badge
[license-url]: https://github.com/2206-devops-batch/ERMS-Project2/blob/master/LICENSE.txt
[linkedin-shield]: https://img.shields.io/badge/-LinkedIn-black.svg?style=for-the-badge&logo=linkedin&colorB=555
[linkedin-url]: https://linkedin.com/in/othneildrew
[product-screenshot]: images/screenshot.PNG
[Docker.com]:https://img.shields.io/badge/Docker-white?style=for-the-badge&logo=docker&logoColor=30B2F5
[Docker-url]:https://www.docker.com/
[DockerHub.com]:https://img.shields.io/badge/DockerHub-white?style=for-the-badge&logo=dockerhub&logoColor=30B2F5
[DockerHub-url]:https://hub.docker.com/
[Jenkins.io]:https://img.shields.io/badge/Jenkins-white?style=for-the-badge&logo=jenkins&logoColor=black
[Jenkins-url]:https://www.jenkins.io/
[GitHub.com]:https://img.shields.io/badge/GitHub-white?style=for-the-badge&logo=github&logoColor=black
[GitHub-url]:https://github.com/
[Kubernetes.io]:https://img.shields.io/badge/Kubernetes-white?style=for-the-badge&logo=kubernetes&logoColor=004DFF
[Kubernetes-url]:https://kubernetes.io/

Testing jenkins webhook 5
