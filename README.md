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
## Getting Started

Be ready to spend a few dollars on this project (we spent around $20 between the four of us). This **requires paid services** from AWS. There are ways to build this without them, but we opted for this path to be better prepared for our working environments.

### Prerequisites

This is an example of how to list things you need to use the software and how to install them.
* npm
  ```sh
  npm install npm@latest -g
  ```

### Installation

_Below is an example of how you can instruct your audience on installing and setting up your app. This template doesn't rely on any external dependencies or services._

1. Get a free API Key at [https://example.com](https://example.com)
2. Clone the repo
   ```sh
   git clone https://github.com/your_username_/Project-Name.git
   ```
3. Install NPM packages
   ```sh
   npm install
   ```
4. Enter your API in `config.js`
   ```js
   const API_KEY = 'ENTER YOUR API';
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
