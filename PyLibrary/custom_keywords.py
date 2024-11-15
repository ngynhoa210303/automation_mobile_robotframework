import os
from pathlib import Path

def pathToProject():
    projectPath = os.getcwd()
    return projectPath

def createNewFolder(folder_path):
    currentProjectPath = pathToProject()
    print(currentProjectPath + folder_path)
    Path(currentProjectPath + folder_path).mkdir(exist_ok=True)

# def captureMan(driver,locator, output_path):
#     element = driver.find_element(AppiumBy.XPATH, locator)  # Thay XPATH bằng loại locator của bạn
#     if element:
#         element.screenshot(output_path)
#     else:
#         raise ValueError(f"Element with locator {locator} not found.")

