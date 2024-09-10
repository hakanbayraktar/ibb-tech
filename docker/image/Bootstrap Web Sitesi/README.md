# Running a Simple Bootstrap Website in a Docker Container with Nginx

This guide will walk you through the steps to set up a simple Bootstrap-based HTML website and run it using Nginx in a Docker container.

## Prerequisites

- Docker installed on your system.
- A Docker Hub account (optional for pushing images).

---

## Step 1: Create a Simple HTML and Bootstrap Website

1. **Create a Project Directory**  
   Start by creating a new directory where you'll store your project files:

   ```bash
   mkdir bootstrap-web
   cd bootstrap-web
Create index.html File
In the project directory, create a file named index.html with the following content:

index.html

<!DOCTYPE html>
<html lang="tr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bootstrap Web Demo</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <nav class="navbar navbar-expand-lg navbar-light bg-light">
        <a class="navbar-brand" href="#">ibb-tech</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item active">
                    <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Docker</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#">Kubernetes</a>
                </li>
            </ul>
        </div>
    </nav>
    <div class="container mt-5">
        <div class="jumbotron">
            <h1 class="display-4">Docker Image!</h1>
            <p class="lead">A Docker image contains the files, dependencies, and configurations needed to run an application. It consists of layers and is portable across environments (development, testing, production).</p>
            <hr class="my-4">
            <p>Images are built using Dockerfiles and are read-only. When a container is run, a writable layer is added on top of the image.</p>
            <a class="btn btn-primary btn-lg" href="#" role="button">Learn more</a>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.4/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>

# Step 2: Create a Dockerfile
In the project directory, create a file named Dockerfile with the following content:

dockerfile
# Use the official Nginx image
FROM nginx:alpine
# Copy HTML files to the Nginx default directory
COPY . /usr/share/nginx/html
# Expose port 80
EXPOSE 80
# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
Step 3: Build the Docker Image
Run the following command to build the Docker image:

# build image
docker build -t bootstrap-web:latest .

Step 4: Verify the Docker Image
Verify that the image was created successfully by listing all Docker images:
docker images

# Step 5: Test the Docker Image
Run the Docker container using the following command:

docker run -d -p 8080:80 bootstrap-web:latest
Open your web browser and navigate to http://localhost:8080 to see the website.

# Step 6: Create a Docker Hub Repository (Optional)
Log into your Docker Hub account or create one.
Click "Create Repository".
Name the repository (e.g., bootstrap-web).
Set visibility to "Public" or "Private" based on your preference.

# Step 7: Tag the Docker Image for Docker Hub
To push the image to Docker Hub, it needs to be tagged with your Docker Hub username and repository name:

docker tag bootstrap-web:latest <your-dockerhub-username>/bootstrap-web:latest
Replace <your-dockerhub-username> with your Docker Hub username.

# Step 8: Log in to Docker Hub
Log into Docker Hub via the command line:

docker login

# Step 9: Push the Docker Image to Docker Hub
Once logged in, push the image to Docker Hub:

docker push <your-dockerhub-username>/bootstrap-web:latest

# Step 10: Verify the Image on Docker Hub
After pushing the image, verify it on Docker Hub:

Go to Docker Hub.
Navigate to your profile and find the bootstrap-web repository.
Verify that the image is listed under "Tags".

# Step 11: Pull and Run the Docker Image from Docker Hub
To test the image pulled from Docker Hub, run the following command on any machine with Docker installed:

docker run -d -p 8080:80 <your-dockerhub-username>/bootstrap-web:latest
Open http://localhost:8080 in your web browser to see the website running from the Docker Hub image.
