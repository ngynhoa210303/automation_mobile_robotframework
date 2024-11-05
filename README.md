# FSI automation testing

## Setup
#### 1. Python
Download and install Python 3.8.0 from https://www.python.org/downloads/release/python-380/ 
- Remind to check Add Python 3.8 to PATH checkbox
- To check python has been installed, open Command Prompt and run command ```python -V```

#### 2. Install packages to run tests
- Open Command Prompt in test project
- Create virtual environment with commands ```python -m venv venv``` and ```pip install virtualenv```
- Activate virtual environment with command ```.\venv\Scripts\activate```
- Upgrade pip version with command ```python -m pip install --upgrade pip```
- Run command ```pip install -r requirements.txt``` to install packages
- Run ```pip list```. If packages robotframework, robotframework-flaui, robotframework-screencaplibrary display in package list then we can run the robot tests

## Run robot tests
Open Command Prompt in test project and active virtual environment with command ```.\venv\Scripts\activate```
#### Command list:
- Run all test cases: ```robot .\Tests\```
- Run test suite: ```robot .\Path\to\test\suite.robot``` for example ```robot .\Tests\Billing\Add_Compatible_Item.robot```
- Run with tag: ```robot -i tag_name .\Tests\``` for example ```robot -i TC-1 .\Tests\```
#### Supporting tags
- Priority: Low, Medium, High, Critical
- Test cases number (example: TC-1, TC-90)
