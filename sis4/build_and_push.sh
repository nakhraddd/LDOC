#!/bin/bash
# Build and push Docker image to Docker Hub

IMAGE_NAME="darkhant/services-app"
TAG="v1"

# Step 1: Create app
cat <<EOF > app.py
from flask import Flask
app = Flask(__name__)

@app.route('/')
def index():
    return "Hello from Flask in Docker!"

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=8080)
EOF

# Step 2: Create Dockerfile
cat <<EOF > Dockerfile
FROM python:3.10-slim
WORKDIR /app
COPY app.py /app
RUN pip install flask
EXPOSE 8080
CMD ["python", "app.py"]
EOF

# Step 3: Build and push image
docker build -t $IMAGE_NAME:$TAG .
docker login -u "<your_dockerhub_username>"
docker push $IMAGE_NAME:$TAG
