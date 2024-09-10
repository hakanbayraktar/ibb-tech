## Java

This example demonstrates how to run a simple "Hello World" Java application using Docker.

### Steps

1. **Create a Dockerfile**

    In your project directory, create a `Dockerfile` with the following contents:

    ```dockerfile
    # Use the official OpenJDK image
    FROM openjdk:17-jdk-slim

    # Copy the Java source file into the container
    COPY HelloWorld.java /app/HelloWorld.java

    # Set the working directory
    WORKDIR /app

    # Compile the Java source file
    RUN javac HelloWorld.java

    # Set the command to run the compiled Java class
    CMD ["java", "HelloWorld"]
    ```

2. **Create the `HelloWorld.java` File**

    In the same directory as your Dockerfile, create a `HelloWorld.java` file with the following code:

    ```java
    public class HelloWorld {
        public static void main(String[] args) {
            System.out.println("Hello, Docker World!");
        }
    }
    ```

3. **Build the Docker Image**

    Use the following command to build the Docker image:

    ```bash
    docker build -t helloworld .
    ```

4. **Run a Container from the Image**

    After building the image, run it using this command:

    ```bash
    docker run --name myhelloworld helloworld
    ```

    This will print `Hello, Docker World!` to the console.