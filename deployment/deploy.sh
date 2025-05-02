#!/bin/bash

# --- Configuration ---
# !!! IMPORTANT: Change these variables to match your setup !!!
CONTAINER_NAME="my-angular-app"                  # Choose a name for your running container
DOCKERHUB_USERNAME="snakelitt"       # Your Docker Hub username
DOCKERHUB_REPO_NAME="angular-app-server"             # Your Docker Hub repository name (e.g., angular-app-server)
IMAGE_TAG="latest"                               # Pull the 'latest' tag
# Optional: Add any docker run options needed (ports, volumes, env vars, etc.)
# Example: RUN_OPTIONS="-p 8080:80 -v /my/local/data:/app/data -e MY_VAR=value"
RUN_OPTIONS="-p 80:80" # Example: Expose container port 80 on host port 80

# Construct the full image name
FULL_IMAGE_NAME="${DOCKERHUB_USERNAME}/${DOCKERHUB_REPO_NAME}:${IMAGE_TAG}"

# --- Script Logic ---

# Exit immediately if a command exits with a non-zero status.
set -e

echo "--- Starting deployment process for ${FULL_IMAGE_NAME} ---"

# Check if Docker daemon is running (optional but good practice)
if ! docker info > /dev/null 2>&1; then
  echo "Error: Docker daemon is not running."
  exit 1
fi

# Stop the currently running container (if it exists)
# -f stops it forcefully if needed
# 2>/dev/null suppresses errors if the container doesn't exist
# || true ensures the script doesn't exit if the container doesn't exist
echo "Stopping existing container: ${CONTAINER_NAME}..."
docker stop "${CONTAINER_NAME}" 2>/dev/null || true

# Remove the stopped container (if it exists)
echo "Removing existing container: ${CONTAINER_NAME}..."
docker rm "${CONTAINER_NAME}" 2>/dev/null || true

# Pull the latest image from Docker Hub
echo "Pulling latest image: ${FULL_IMAGE_NAME}..."
docker pull "${FULL_IMAGE_NAME}"

# Run the new container
echo "Running new container: ${CONTAINER_NAME} from image ${FULL_IMAGE_NAME}..."
# Explanation of docker run flags:
# -d : Run container in detached mode (in the background)
# --name : Assign a name to the container
# ${RUN_OPTIONS} : Include your custom options (ports, volumes, etc.)
# ${FULL_IMAGE_NAME} : The image to run
docker run -d --name "${CONTAINER_NAME}" ${RUN_OPTIONS} "${FULL_IMAGE_NAME}"

echo "--- Deployment finished successfully ---"
echo "Container '${CONTAINER_NAME}' is running with image '${FULL_IMAGE_NAME}'."

exit 0
