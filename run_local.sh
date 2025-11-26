#!/bin/bash

# Script to run the Student Management application locally
# This script sets up virtual environments and installs dependencies for both backend and frontend

set -e  # Exit on error

echo "=========================================="
echo "Student Management - Local Setup Script"
echo "=========================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check if command exists
command_exists() {
    command -v "$1" >/dev/null 2>&1
}

# Check prerequisites
echo -e "${BLUE}Checking prerequisites...${NC}"
if ! command_exists python3; then
    echo -e "${YELLOW}Error: Python 3 is not installed${NC}"
    exit 1
fi

if ! command_exists node; then
    echo -e "${YELLOW}Error: Node.js is not installed${NC}"
    exit 1
fi

if ! command_exists npm; then
    echo -e "${YELLOW}Error: npm is not installed${NC}"
    exit 1
fi

echo -e "${GREEN}✓ All prerequisites met${NC}"
echo ""

# Backend setup
echo -e "${BLUE}Setting up Backend...${NC}"
cd backend

# Create virtual environment if it doesn't exist
if [ ! -d ".venv" ]; then
    echo "Creating Python virtual environment..."
    python3 -m venv .venv
fi

# Activate virtual environment
echo "Activating virtual environment..."
source .venv/bin/activate

# Install/upgrade pip
echo "Upgrading pip..."
pip install --upgrade pip --quiet

# Install dependencies
echo "Installing Python dependencies..."
pip install -r requirements.txt --quiet

# Check if .env file exists
if [ ! -f ".env" ]; then
    echo -e "${YELLOW}Warning: .env file not found. Creating from .env.example...${NC}"
    if [ -f ".env.example" ]; then
        cp .env.example .env
        echo -e "${GREEN}✓ Created .env file. Please update it with your configuration.${NC}"
    else
        echo -e "${YELLOW}Warning: .env.example not found. You may need to create .env manually.${NC}"
    fi
fi

echo -e "${GREEN}✓ Backend setup complete${NC}"
cd ..
echo ""

# Frontend setup
echo -e "${BLUE}Setting up Frontend...${NC}"
cd frontend/student_management

# Create .env file if it doesn't exist
if [ ! -f ".env" ]; then
    echo "Creating frontend .env file..."
    echo "REACT_APP_API_BASE=http://localhost:5000/api" > .env
fi

# Install dependencies
echo "Installing Node.js dependencies..."
npm install

echo -e "${GREEN}✓ Frontend setup complete${NC}"
cd ../..
echo ""

# Instructions
echo -e "${GREEN}=========================================="
echo "Setup Complete!"
echo "==========================================${NC}"
echo ""
echo "To run the application:"
echo ""
echo -e "${BLUE}Backend:${NC}"
echo "  cd backend"
echo "  source .venv/bin/activate"
echo "  python app.py"
echo ""
echo -e "${BLUE}Frontend:${NC}"
echo "  cd frontend/student_management"
echo "  npm start"
echo ""
echo -e "${YELLOW}Note: Make sure PostgreSQL is running on localhost:5432${NC}"
echo ""

