import os
import sys
from PIL import Image


def to_png(path, name):
    print(f'{path}/{name}.jpg >> {path}/{name}.png')
    Image.open(f'{path}/{name}.jpg').save(f'{path}/{name}.png')


def rename(path):
    for file in os.listdir(path):
        fpath = os.path.join(path, file)
        if (os.path.isfile(fpath)):
            ext = os.path.splitext(file)
            if (ext[1] == '.jpg'):
                to_png(path, ext[0])


if len(sys.argv) < 2:
    print(sys.argv[0], 'path')
    sys.exit(1)

path = sys.argv[1]
rename(path)
