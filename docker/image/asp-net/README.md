# Step 1: Installing Docker

sudo apt-get update -y
sudo apt-get install ca-certificates curl -y
sudo install -m 0755 -d /etc/apt/keyrings -y
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo \
 "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
 $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
 sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
 sudo apt-get update -y
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y

# Step 2: Installing Required Dependencies
sudo apt-get update
sudo apt-get install -y libicu-dev apt-transport-https

# Step 3: Installing Microsoft Package Repository and .NET 8 SDK
wget https://packages.microsoft.com/config/ubuntu/24.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb
sudo dpkg -i packages-microsoft-prod.deb
sudo apt-get update
sudo apt-get install -y dotnet-sdk-8.0

# Step 4: Verifying the Installation
dotnet --version

# Step 5: Creating an ASP.NET Core Web Application
mkdir AspNetCoreWebApp
cd AspNetCoreWebApp
dotnet new web -o MyWebApp

# Step 6: Creating a Dockerfile
cd MyWebApp
touch Dockerfile

vi Dockerfile
# Use .NET 8 SDK to build the application
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
# Set the working directory
WORKDIR /app
# Copy the project files
COPY . .
# Restore and build the project
RUN dotnet restore
RUN dotnet publish -c Release -o out
# Final stage: run the application using the ASP.NET Core runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .
# Expose port 80 for the application
EXPOSE 80
# Set the application to listen on IPv4 only
ENV ASPNETCORE_URLS=http://0.0.0.0:80
# Run the application
ENTRYPOINT ["dotnet", "MyWebApp.dll"]

# Step 7: Building the Docker Image
docker build -t my-dotnet8-webapp .

# Step 8: Running the Docker Container
docker run -d -p 8080:80 --name dotnet8_web_sample my-dotnet8-webapp

