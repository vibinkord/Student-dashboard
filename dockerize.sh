#!/bin/bash

# Script to build and tag Docker images for the Student Management application
# Usage: ./dockerize.sh [version]
# Example: ./dockerize.sh 1.0.0

set -e  # Exit on error

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check if Docker is installed
if ! command_exists docker; then
    echo -e "${RED}Error: Docker is not installed${NC}"
    exit 1
fi

# Get version from command line argument or use default
VERSION=${1:-"latest"}
IMAGE_PREFIX="student-management"

echo -e "${BLUE}=========================================="
echo "Docker Image Building Script"
echo "==========================================${NC}"
echo ""
echo -e "${BLUE}Version: ${VERSION}${NC}"
echo ""

# Build backend image
echo -e "${BLUE}Building backend image...${NC}"
cd backend
docker build -t ${IMAGE_PREFIX}-backend:${VERSION} .
docker tag ${IMAGE_PREFIX}-backend:${VERSION} ${IMAGE_PREFIX}-backend:latest
echo -e "${GREEN}✓ Backend image built: ${IMAGE_PREFIX}-backend:${VERSION}${NC}"
cd ..

# Build frontend image
echo -e "${BLUE}Building frontend image...${NC}"
cd frontend/student_management
docker build -t ${IMAGE_PREFIX}-frontend:${VERSION} .
docker tag ${IMAGE_PREFIX}-frontend:${VERSION} ${IMAGE_PREFIX}-frontend:latest
echo -e "${GREEN}✓ Frontend image built: ${IMAGE_PREFIX}-frontend:${VERSION}${NC}"
cd ../..

echo ""
echo -e "${GREEN}=========================================="
echo "Build Complete!"
echo "==========================================${NC}"
echo ""
echo "Images created:"
echo "  - ${IMAGE_PREFIX}-backend:${VERSION}"
echo "  - ${IMAGE_PREFIX}-backend:latest"
echo "  - ${IMAGE_PREFIX}-frontend:${VERSION}"
echo "  - ${IMAGE_PREFIX}-frontend:latest"
echo ""
echo -e "${YELLOW}To push to Docker Hub, run:${NC}"
echo "  docker tag ${IMAGE_PREFIX}-backend:${VERSION} <your-dockerhub-username>/${IMAGE_PREFIX}-backend:${VERSION}"
echo "  docker tag ${IMAGE_PREFIX}-frontend:${VERSION} <your-dockerhub-username>/${IMAGE_PREFIX}-frontend:${VERSION}"
echo ""
echo "  docker push <your-dockerhub-username>/${IMAGE_PREFIX}-backend:${VERSION}"
echo "  docker push <your-dockerhub-username>/${IMAGE_PREFIX}-frontend:${VERSION}"
echo ""

