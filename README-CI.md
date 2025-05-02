# Project 4

## Part 1

- Installing Docker is done by installing Docker desktop. I used this article to help me out [Docker Download](https://docs.docker.com/desktop/features/wsl/).  
- To make sure it is downloaded, I just typed `docker` in the WSL command line. 
- Made a file called Dockerfile using [google ai](https://aistudio.google.com/prompts/new_chat)
- Ran the Docker file in the angular-site folder in my [DockerProj4 Repository](https://github.com/SnakeLitt/DockerProj4).  
- I used the command `docker build -t angular-app-server . ` to build the image and container.  -t tags the build with the name and the . puts it in the current directory.  
- To run the image I did `docker run -d -p 8080:8080 --name my-angular-container angular-app-server` 
- I validated the running container by going to the docker desktop and seeing it is running.  
- I created a docker hub repository by going to [Docker Hub](https://hub.docker.com/repositories/snakelitt) and hitting create repository.  
- I could not figure our how to change the name when making the repository. The repository name is `angular-app-server`
- Creating the PAT by going to my settings, created a new PAT then put it into my command line by doing `docker login` 
- When doing the push(`docker push snakelitt/angular-app-server:v01.0`), I had to retag my repository because having the "latest" tag was not working. So I did, `docker tag snakelitt/angular-app-server:latest snakelitt/angular-app-server:v01.0` 
- Link to [Docker Hub](https://hub.docker.com/repository/docker/snakelitt/angular-app-server/general)
## Part 2
- Created the PAT the same way before, then put the PAT in the `actions secrets` and the username in the `actions variable`. 
- I created the secrets by going to my repository, going to the settings, and setting them up in the secrets tab. 
- All the workflow file does is create a new repository in dockerhub.  [Workflow](https://github.com/SnakeLitt/DockerProj4/tree/main/.github/workflows)


## Part 3

The goal of this project is to create a new way to run a program outside of AWS.  
The tools used in this project was dockerhub, angular app, github, google searches and some ai.  
Dockerhub is the tool for containers, images, etc.  
Angular is to help with server. 
Github is github. 
Google searches and ai help me with the coding of bash in files. 
