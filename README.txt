Exif Renamer
============
The "Exif Renamer" is a simple tool for renaming photos by Exif data and storing into folder named by date.

thanks to

  - [Python](http://www.python.org)
  - [EXIF.py](https://github.com/ianare/exif-py)
  - [AutoHotkey](http://www.autohotkey.net)

This tool had tested on Windows XP with photos took by my **HTC Mozart** and **Google Nexus S** phones.

Exif-rename is dividing into two part.

  1. the core command: **exifrename.exe**
  2. the gui: **gui.exe**

**exifrename.exe** was wrote by Python with EXIF.py and packed by PyInstaller.

**gui.exe** was wrote by AutoHotKey and complied into `.exe` file.

License
-------
this project is under the terms of the MIT License.

see [MIT-LICENSE.txt](MIT-LICENSE.txt)

2022 年 03 月 11 日 补充
-------

exifrename 的源代码最初写于 2013 年。是我能找到的，自己最早的代码，毕竟当时并没有使用 git 管理代码。这个版本之后，就改用 golang 实现了一个相同功能的工具：[picar](https://github.com/yuekcc/picar)。后续也正式使用 git 管理自己的代码了。

```
total 48K
drwxr-xr-x 1 feng 197121    0 May  2  2013 ./
drwxr-xr-x 1 feng 197121    0 May  2  2013 ../
-rwxr-xr-x 1 feng 197121  68K Mar 25  2013 EXIF.py*
-rw-r--r-- 1 feng 197121 1.1K Mar 28  2013 exifrename.py
-rw-r--r-- 1 feng 197121  668 Mar 26  2013 exifrename.spec
-rw-r--r-- 1 feng 197121 1.4K Mar 28  2013 worker.py
```
