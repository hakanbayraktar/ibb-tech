# Step 1: Install Maven on Ubuntu
sudo apt update
sudo apt install maven -y
mvn -version

# Step 2: Installing OpenJDK
sudo apt update
sudo apt install default-jdk -y
java -version

# Step 3: Building the Java Application JAR
    # Clone the sample Java application:
    git clone https://github.com/hakanbayraktar/java-spring-petclinic
    # Navigate to the project directory:
    cd java-spring-petclinic
    # Build the project using Maven:
    mvn clean install -Dmaven.test.skip=true

# Step 4: Creating a Docker Image for Your Java Application
Dockerfile
FROM openjdk:17-jdk-slim
WORKDIR /app
COPY /target/*.jar ./java.jar
EXPOSE 8080
CMD ["java", "-jar", "java.jar"]

# Step 5: Building and Running the Docker Container
docker build -t java-app:1.0 .
docker run -d -p 80:8080 java-app:1.0

http://<your-server-ip>.