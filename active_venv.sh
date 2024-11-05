#!/bin/bash

# Check if the virtual environment exists
if [ ! -d "venv" ]; then
    echo "Virtual environment not found. Creating a new one..."
    python -m venv venv
fi

# Activate the virtual environment
source ./venv/Scripts/activate

# Install dependencies from requirements.txt
pip install -r requirements.txt

source venv/Scripts/activate

echo "Virtual environment activated and dependencies installed."
