# -*- coding: utf-8 -*-

"""
一个简单的 EXIF 照片重命名工具
使用：
	exifrename.py -p prefix_string [path]
	exifrename.py -h
	exifrename.py [path]
"""

import sys
import os
import getopt


def print_help():
    msg = """exifrename is a tool for archiving photos

usage:
    exifrename --prefix=file_prefix [dir]
    exifrename -p file_prefix [dir]
    exifrename -h
"""
    print(msg)
    sys.exit(1)


def parse_cli() -> tuple[str, str]:
    try:
        opts, args = getopt.getopt(sys.argv[1:], "hp:", ["help", "prefix="])
    except getopt.GetoptError:
        print_help()

    if len(args) == 0:
        print_help()

    dir = args[0]
    prefix = ""

    if not os.path.isdir(dir):
        print_help()

    for o, a in opts:
        if o in ("-h", "--help"):
            print_help()
        elif o in ("-p", "--prefix"):
            prefix = a

    return (dir, prefix)


def start_exifrename():
    # 处理命令行
    dir, prefix = parse_cli()

    # 主流程
    from .worker import parse
    parse(dir, prefix)


if __name__ == '__main__':
    start_exifrename()
