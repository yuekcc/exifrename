# -*- coding: utf-8 -*-
import os
import shutil
import EXIF


def parse(dir='.', prefix=""):
    print("PROCESSING FLODER: {0}".format(dir))

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
        f = open(file_path, 'rb')

        print("."),

        exifdata = EXIF.process_file(f)
        f.close()

        datetime_fields = [
            'EXIF DateTimeDigitized',
            'EXIF DateTimeOriginal',
            'Image DateTime',
        ]

        dt = []
        for tag in datetime_fields:
            if tag in exifdata:
                dt = str(exifdata[tag]).split()
                break

        if prefix:
            p = prefix
        else:
            p = str(exifdata['Image Model'])

        if len(dt) >= 2:
            d = dt[0].replace(':', '')
            t = dt[1].replace(':', '')
        
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
