import os
from pathlib import Path

def pathToProject():
    projectPath = os.getcwd()
    return projectPath

def createNewFolder(folder_path):
    currentProjectPath = pathToProject()
    print(currentProjectPath + folder_path)
    Path(currentProjectPath + folder_path).mkdir(exist_ok=True)