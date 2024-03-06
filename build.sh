#!/bin/bash

PKG_CONFIG_PATH=/usr/x86_64-w64-mingw32/sys-root/mingw/lib/pkgconfig \
	CGO_ENABLED=1 \
	GOOS=windows \
	CC="x86_64-w64-mingw32-gcc" \
	go build -v -ldflags -H=windowsgui -o builds/program.exe
