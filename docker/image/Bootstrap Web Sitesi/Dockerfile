# Use the official Nginx image
FROM nginx:alpine

# Copy HTML files to the Nginx default directory
COPY . /usr/share/nginx/html

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]
