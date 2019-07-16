import os
import numpy as np
import cv2 as cv


def resize(path, name, ext):
    print(f'{path}/{name}{ext} >> {path}/{name}-icon.jpg')
    img = cv.imread(f'{path}/{name}{ext}')
    img = cv.resize(img, None, fx=0.2, fy=0.2)
    cv.imwrite(f'{path}/{name}-icon.jpg', img)


path = '../assets'
for file in os.listdir(path):
    fpath = os.path.join(path, file)
    if (os.path.isfile(fpath)):
        ext = os.path.splitext(file)
        if (ext[1] == '.png'):
            resize(path, ext[0], ext[1])
