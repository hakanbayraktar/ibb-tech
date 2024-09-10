# Use a multi-stage build to keep the final image small

# Stage 1: Build the Go application
FROM golang:1.20 AS builder

# Set the Current Working Directory inside the container
WORKDIR /app

# Initialize the Go module and create go.mod inside the container
RUN go mod init example.com/myapp || true

# Copy the source code into the container
COPY . .

# Download the dependencies
RUN go mod tidy

# Build the Go app
RUN go build -o main .

# Stage 2: Use the same Go base image for the final runtime environment
FROM golang:1.20

# Set the Current Working Directory inside the container
WORKDIR /root/

# Copy the Pre-built binary file from the previous stage
COPY --from=builder /app/main .

# Expose port 8080 to the outside world
EXPOSE 8080

# Run the binary program produced by `go build`
CMD ["./main"]

