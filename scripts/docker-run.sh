#!/usr/bin/env bash

# From: https://jenkins.io/doc/book/installing/#docker
#( Optional ) Automatically removes the Docker container (which is the instantiation of the jenkinsci/blueocean image below) when it is shut down. This keeps things tidy if you need to quit Jenkins.
#( Optional ) Runs the jenkinsci/blueocean container in the background (i.e. "detached" mode) and outputs the container ID. If you do not specify this option, then the running Docker log for this container is output in the terminal window.
#Maps (i.e. "publishes") port 8080 of the jenkinsci/blueocean container to port 8080 on the host machine. The first number represents the port on the host while the last represents the container’s port. Therefore, if you specified -p 49000:8080 for this option, you would be accessing Jenkins on your host machine through port 49000.
#( Optional ) Maps port 50000 of the jenkinsci/blueocean container to port 50000 on the host machine. This is only necessary if you have set up one or more JNLP-based Jenkins agents on other machines, which in turn interact with the jenkinsci/blueocean container (acting as the "master" Jenkins server, or simply "Jenkins master"). JNLP-based Jenkins agents communicate with the Jenkins master through TCP port 50000 by default. You can change this port number on your Jenkins master through the Configure Global Security page. If you were to change your Jenkins master’s TCP port for JNLP agents value to 51000 (for example), then you would need to re-run Jenkins (via this docker run …​ command) and specify this "publish" option with something like -p 52000:51000, where the last value matches this changed value on the Jenkins master and the first value is the port number on the Jenkins master’s host machine through which the JNLP-based Jenkins agents communicate (to the Jenkins master) - i.e. 52000.
#( Optional but highly recommended ) Maps the /var/jenkins_home directory in the container to the Docker volume with the name jenkins-data. If this volume does not exist, then this docker run command will automatically create the volume for you. This option is required if you want your Jenkins state to persist each time you restart Jenkins (via this docker run …​ command). If you do not specify this option, then Jenkins will effectively reset to a new instance after each restart.
#Notes: The jenkins-data volume could also be created independently using the docker volume create command:
#docker volume create jenkins-data
#Instead of mapping the /var/jenkins_home directory to a Docker volume, you could also map this directory to one on your machine’s local file system. For example, specifying the option
#-v $HOME/jenkins:/var/jenkins_home would map the container’s /var/jenkins_home directory to the jenkins subdirectory within the $HOME directory on your local machine, which would typically be /Users/<your-username>/jenkins or /home/<your-username>/jenkins.
#( Optional ) /var/run/docker.sock represents the Unix-based socket through which the Docker daemon listens on. This mapping allows the jenkinsci/blueocean container to communicate with the Docker daemon, which is required if the jenkinsci/blueocean container needs to instantiate other Docker containers. This option is necessary if you run declarative Pipelines whose syntax contains the agent section with the docker parameter - i.e.
#agent { docker { …​ } }. Read more about this on the Pipeline Syntax page.
#The jenkinsci/blueocean Docker image itself. If this image has not already been downloaded, then this docker run command will automtically download the image for you. Furthermore, if any updates to this image were published since you last ran this command, then running this command again will automatically download these published image updates for you.
#Note: This Docker image could also be downloaded (or updated) independently using the docker pull command:
#docker pull jenkinsci/blueocean

docker run \
  -u root \
  --rm \
  --name jenkins-blueocean \
  -d \
  -p 8080:8080 \
  -p 50000:50000 \
  -v jenkins-data:/var/jenkins_home \
  -v /var/run/docker.sock:/var/run/docker.sock \
  jenkinsci/blueocean                             
