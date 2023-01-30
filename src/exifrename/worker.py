# -*- coding: utf-8 -*-
import os
import shutil
import pathlib
from datetime import datetime
import time

from _vendor import piexif


def parse(dir='.', prefix=""):
    print("PROCESSING FOLDER: {0}".format(dir))

    file_list = os.listdir(dir)

    for file_path in file_list:
        print(" -> FILE: {0}".format(file_path)),

        if os.path.isdir(file_path):
            print('... FLODER. !!DO NOTHING!!')
            continue

        n, ext = os.path.splitext(file_path)
        if not (ext == '.jpg'):
            print('... NOT .JPG FILE. !!DO NOTHING!!')
            continue

        file_path = os.path.join(dir, file_path)

        print("."),

        exif_data = piexif.load(file_path)
        tags = [
            piexif.ExifIFD.DateTimeDigitized,
            piexif.ExifIFD.DateTimeOriginal,
            piexif.ImageIFD.DateTime
        ]

        dt = []
        for tag in tags:
            if tag in exif_data:
                print(f"{tag} => {exif_data[tag]}")
                dt = str(exif_data[tag]).split()
                break

        if len(dt) == 0:
            file_state = pathlib.Path(file_path).stat()
            created_dt = datetime.fromtimestamp(file_state.st_ctime)
            dt = created_dt.strftime("%Y%m%d %H%M%S").split()

        if prefix:
            p = prefix
        else:
            p = str(exif_data['Image Model'])

        if len(dt) >= 2:
            d = dt[0].replace(':', '')
            t = dt[1].replace(':', '')

        # FIXME 无 exif 时间日期时如何处理
        new_name = '{0}-{1}-{2}.jpg'.format(p, d, t)

        print("."),

        dirname = os.path.dirname(file_path)
        # 按月生成目录，格式 201203
        new_dir = os.path.join(dirname, d[:6])
        new_fullname = os.path.join(new_dir, new_name)

        print("."),

        if not os.path.isdir(new_dir):
            os.mkdir(new_dir)

        if not os.path.isfile(new_fullname):
            try:
                shutil.move(file_path, new_fullname)
            except:
                pass

        print('DONE')
