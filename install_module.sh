#!/bin/bash
# Check if venv directory exists
if [ ! -d "venv" ]; then
    echo "Virtual environment (venv) does not exist. Please create it before running this script."
    exit 1
fi
# Check if module name is provided
if [ -z "$1" ]
then
    echo "No module name provided. Usage: bash install_module.sh <module_name>"
    exit 1
fi

# Activate virtual environment
source venv/Scripts/activate

# Install the module
pip install $1

# Update requirements.txt
pip freeze > requirements.txt

# Deactivate virtual environment
deactivate

echo "Module $1 installed and requirements.txt updated."