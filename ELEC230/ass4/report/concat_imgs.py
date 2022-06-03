import numpy as np

from pathlib import Path
from PIL import Image

img1 = np.array(Image.open(Path('./1.png')))
img2 = np.array(Image.open(Path('./2.png')))[:847]

Image.fromarray(np.concatenate((img1, img2), axis=1)).save('result.png')
