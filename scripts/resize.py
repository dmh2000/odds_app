import os
import sys
import numpy as np
import cv2 as cv


def resize_image(ratio, path, name, ext):
    print(f'{path}/{name}{ext} >> {path}/{name}{ext}')
    img = cv.imread(f'{path}/{name}{ext}')
    img = cv.resize(img, None, fx=ratio, fy=ratio)
    cv.imwrite(f'{path}/{name}.jpg', img)


def resize(path,ratio):
    for file in os.listdir(path):
        fpath = os.path.join(path, file)
        if (os.path.isfile(fpath)):
            ext = os.path.splitext(file)
            if (ext[1] == '.png')or(ext[1] == '.jpg'):
                resize_image(ratio, path, ext[0], ext[1])


if len(sys.argv) < 3:
    print(sys.argv[0],'path','ratio')
    sys.exit(1)

path = sys.argv[1]
ratio = float(sys.argv[2])
resize(path,ratio)
