# 默认
default: build

_prepare-dist-dir:
    #!/bin/sh
    find . -type d -name __pycache__ -exec rm -rf {} \;
    test -d dist && rm -rf dist
    mkdir -p dist/exifrename

# 构建应用
build: _prepare-dist-dir install-app install-loader

# 安装依赖
_install-vendor:
    cd src/exifrename && pip install -r requirements.txt -t _vendor

# 只安装 python app
install-app:
    #!/bin/sh
    mkdir -p dist/exifrename
    cp -r src/exifrename/* dist/exifrename/
    # python -m compileall dist/exifrename/

# 构建 loader
_build-loader:
    #!/bin/sh
    cd bin
    cargo clean
    cargo build --release

# 只构建 loader
install-loader: _build-loader
    #!/bin/sh
    mkdir -p dist/exifrename
    cp bin/target/release/exifrename.exe dist/exifrename/exifrename.exe
