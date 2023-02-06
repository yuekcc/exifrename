# exifrename

Exif Renamer 是一个用于归档照片到不同的目录的小工具。

## 使用

在 [Release](https://github.com/yuekcc/exifrename/releases) 页面下载最近的版本，解压后，将路径加入系统 `$PATH` 中。然后可以在命令行执行：

```sh
exifrename -h
```

**运行需要 python3.9+**，推荐使用最新版本。

## 构建

构建需要使用 [just] 或手工执行 justfile 菜单。

构建需要 pip、rust 1.6+。

执行：

```sh
just build
```

[just]: https://github.com/casey/just

## 一点历史

exifrename 最初在 2013 年编写实现。也是我能找到的最早的代码。2013 年的版本可以在 master 分支找到，当前的分支为 python3 适配的版本。

exifrename 后续使用 [go 重写][picar]，也做了一个 [rust 的版本][picar-rs]。

[picar]: https://github.com/yuekcc/picar
[picar-rs]: https://github.com/yuekcc/picar-rs

## LICENSE

[MIT](LICENSE)
