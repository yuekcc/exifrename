default: build

# 安装依赖
install-vendor:
    cd src/exifrename && pip install -r requirements.txt -t _vendor

# 构建 loader
build-loader:
    #!/bin/sh
    cd bin
    cargo clean
    cargo build --release

# 构建应用
build: install-vendor build-loader
    #!/bin/sh
    find . -type d -name __pycache__ -exec rm -rf {} \;
    test -d dist && rm -rf dist
    mkdir -p dist/exifrename
    
    cp -r src/exifrename/* dist/exifrename/
    python -m compileall dist/exifrename/

    cp bin/target/release/exifrename.exe dist/exifrename/exifrename.exe

# 只构建 loader
install-loader: build-loader
    #!/bin/sh
    mkdir -p dist/exifrename
    cp bin/target/release/exifrename.exe dist/exifrename/exifrename.exe
