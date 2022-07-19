#!/usr/bin/env bash

## Complete the following steps to get Docker running locally

# Step 1:
# Build image and add a descriptive tag
docker build -t mshmsudd/green-flask-app:$BUILD_NUMBER .

# Step 2: 
# List docker images
#sudo docker image ls

# Step 3: 
# Run flask app
#sudo docker run -p 8000:80 capstonegreenappimage