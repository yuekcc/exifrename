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

#from worker import worker
VERSION = '1.1'

def usage(t):
	print("exifrename.py version:{0}\n".format(VERSION))
	print("a console tools for rename photo by EXIF datatime.")
	print("usage:")
	print("python exifrename.py --prefix=name dir")
	print("python exifrename.py -p prefix-name dir")
	print("python exifrename.py -h")

	if t == 0:
		sys.exit(0)
	if t == 2:
		sys.exit(1)

if __name__ == '__main__':
	try:
	    opts, args = getopt.getopt(sys.argv[1:], "hp:", ["help", "prefix="])
	except getopt.GetoptError:
		usage(2)

	if args == []:
		usage(2)		

	srcdir = args[0]
	prefix = ""

	if not os.path.isdir(srcdir):
		usage(2)

	for o, a in opts:
		if o in ("-h", "--help"):
			usage(0)
		elif o in ("-p", "--prefix"):
			prefix = a

	# 处理目录
	from worker import worker
	worker(srcdir, prefix)
