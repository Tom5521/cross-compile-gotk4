FROM fedora:latest


WORKDIR /tmp/

RUN echo Installing dependencies...
RUN dnf install -y git mingw64-gtk4 mingw64-gcc wget zstd


RUN echo Installing golang...
RUN wget -O go.tar.gz "https://go.dev/dl/go1.22.0.linux-amd64.tar.gz"
RUN rm -rf /usr/local/go && tar -C /usr/local -xzf go.tar.gz
ENV PATH="$PATH:/usr/local/go/bin"

RUN echo Downloading mingw64 dependencies...
RUN wget -O libadwaita.tar.zst \
  "https://mirror.msys2.org/mingw/mingw64/mingw-w64-x86_64-libadwaita-1.4.4-1-any.pkg.tar.zst"
RUN wget -O gobject-introspection.tar.zst \
  "https://mirror.msys2.org/mingw/mingw64/mingw-w64-x86_64-gobject-introspection-1.78.1-1-any.pkg.tar.zst"
RUN wget -O gobject-introspection-runtime.tar.zst \
  "https://mirror.msys2.org/mingw/mingw64/mingw-w64-x86_64-gobject-introspection-runtime-1.78.1-1-any.pkg.tar.zst"
RUN echo Installing...
RUN tar -xf libadwaita.tar.zst
RUN tar -xf gobject-introspection.tar.zst
RUN tar -xf gobject-introspection-runtime.tar.zst
RUN cp mingw64/* /usr/x86_64-w64-mingw32/ -rf


RUN echo Patching gobject-introspection-1.0.pc...
COPY ./gobject-introspection-1.0.pc /usr/x86_64-w64-mingw32/lib/pkgconfig/gobject-introspection-1.0.pc
RUN ln -s /usr/x86_64-w64-mingw32/lib/pkgconfig/gobject-introspection-1.0.pc /usr/x86_64-w64-mingw32/sys-root/mingw/lib/pkgconfig


RUN mkdir /root/proyect
WORKDIR /root/proyect
COPY . .


CMD sleep infinity




