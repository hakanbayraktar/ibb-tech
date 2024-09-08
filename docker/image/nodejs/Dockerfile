# Node.js base image (latest LTS version)
FROM node:20-slim

# Label for metadata
LABEL "about"="This file demonstrates a basic Node.js app with Docker."

# Set environment variable for the working directory
ENV dizin=/home/ibb-tech

# Create and set permissions for the working directory
RUN mkdir -p $dizin && chown node:node $dizin

# Create volume

# Switch to non-root user
USER node

# Set the working directory
WORKDIR $dizin

# Copy package.json and install dependencies
COPY --chown=node:node package.json ./

RUN npm install
USER root
RUN mkdir -p /data && chmod 777 /data
# Copy the application files
COPY --chown=node:node index.js ./
CMD ["sh", "-c", "echo 'Log Starting' > /data/log.txt && node index.js"]

# Expose port 3070
EXPOSE 3070

