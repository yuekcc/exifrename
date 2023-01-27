init-vendor:
    cd src/exifrename && pip install -r requirements.txt -t _vendor

build: init-vendor
    #!/bin/sh
    find . -type d -name __pycache__ -exec rm -rf {} \;
    test -d dist && rm -rf dist
    mkdir -p dist/exifrename
    cp -r src/exifrename/* dist/exifrename
