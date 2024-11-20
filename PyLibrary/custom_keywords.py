import os
from pathlib import Path
from skimage.metrics import structural_similarity as ssim
from PIL import Image
import cv2

def pathToProject():
    projectPath = os.getcwd()
    return projectPath

def createNewFolder(folder_path):
    currentProjectPath = pathToProject()
    print(currentProjectPath + folder_path)
    Path(currentProjectPath + folder_path).mkdir(exist_ok=True)
    
def compare_images(image1_path, image2_path, threshold=0.9):
    """
    Compare two images using SSIM and return whether they are similar.

    Args:
        image1_path (str): Path to the first image.
        image2_path (str): Path to the second image.
        threshold (float): Similarity threshold (0 to 1). Default is 0.9.

    Returns:
        bool: True if images are similar, False otherwise.
    """
    img1 = cv2.imread(image1_path, cv2.IMREAD_GRAYSCALE)
    img2 = cv2.imread(image2_path, cv2.IMREAD_GRAYSCALE)
    if img1 is None or img2 is None:
        raise FileNotFoundError("One of the images was not found.")
    score, _ = ssim(img1, img2, full=True)
    return score <= threshold

def crop_image(input_image, x1, y1, x2, y2, output_image):
    """
    Crop a specific region from the input image and save it to a new file.

    Args:
        input_image (str): Path to the input image.
        x (int): X-coordinate of the top-left corner of the crop area.
        y (int): Y-coordinate of the top-left corner of the crop area.
        width (int): Width of the crop area.
        height (int): Height of the crop area.
        output_image (str): Path to save the cropped image.
    """
    if not os.path.exists(input_image):
        raise FileNotFoundError(f"Input image {input_image} does not exist.")
    try:
        image = Image.open(input_image)
    except Exception as e:
        raise ValueError(f"Error opening image {input_image}: {e}")
    width= x2-x1
    height= y2-y1
    if x1 < 0 or y1 < 0 or x1 + width > image.width or y1 + height > image.height:
        raise ValueError(f"Invalid crop dimensions: ({x1}, {y1}, {width}, {height})")
    cropped = image.crop((x1, y1, x1 + width, y1 + height))
    try:
        cropped.save(output_image)
        print(f"Cropped image saved as {output_image}")
    except Exception as e:
        raise ValueError(f"Error saving cropped image: {e}")
