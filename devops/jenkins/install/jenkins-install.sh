#!/bin/bash

# Variables for colored messages
PURPLE='\033[0;35m'
NC='\033[0m' # No color

# Update the package directory and install the necessary packages
echo -e "${PURPLE}Updating package directory and installing required packages...${NC}"
sudo apt update
sudo apt install -y openjdk-17-jdk maven

# Download the Jenkins repository key
echo -e "${PURPLE}Downloading Jenkins repository key...${NC}"
sudo wget -O /usr/share/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key

# Add the Jenkins repository
echo -e "${PURPLE}Adding Jenkins repository...${NC}"
echo deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update the package directory again
echo -e "${PURPLE}Updating package directory...${NC}"
sudo apt update

# Install Jenkins
echo -e "${PURPLE}Installing Jenkins...${NC}"
sudo apt install -y jenkins

# Start the Jenkins service
echo -e "${PURPLE}Starting Jenkins service...${NC}"
sudo systemctl start jenkins

# Wait for the service to start
sleep 10

# Retrieve the initial admin password
if [ -f /var/lib/jenkins/secrets/initialAdminPassword ]; then
    INITIAL_PASSWORD=$(sudo cat /var/lib/jenkins/secrets/initialAdminPassword)

    # Display the login information
    clear
    cat << EOF
===============================
Jenkins Installation Completed!
===============================

To access the Jenkins Dashboard:

    http://$(curl -s ifconfig.me):8080

Login information:

Password: ${INITIAL_PASSWORD}

EOF
else
    echo -e "${PURPLE}initialAdminPassword file not found. Jenkins may not have started properly.${NC}"
fi
