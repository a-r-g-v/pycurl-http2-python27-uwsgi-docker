FROM ubuntu:16.04


RUN apt-get update -y && apt-get upgrade -y
RUN apt-get install -y python sqlite3 python-dev python-pip curl libssl-dev libcurl4-openssl-dev nghttp2 git libmysqlclient-dev
RUN pip install --upgrade pip

# libnghttp2
RUN apt-get install libboost-all-dev libboost-dev wget libnghttp2-dev -y
RUN wget https://github.com/nghttp2/nghttp2/releases/download/v1.9.2/nghttp2-1.9.2.tar.bz2 && \
    tar xf nghttp2-1.9.2.tar.bz2 && \
    cd nghttp2-1.9.2 && \
    ./configure --enable-asio-lib && \
    make && \
    make install

RUN wget https://github.com/progrium/entrykit/releases/download/v0.4.0/entrykit_0.4.0_Linux_x86_64.tgz && \
    tar xf entrykit_0.4.0_Linux_x86_64.tgz && \
    mv ./entrykit /usr/local/bin/. && \
    chmod +x /usr/local/bin/entrykit && \
    entrykit --symlink

RUN apt-get clean && rm -rf /var/lib/apt/lists/*


# libcurl
RUN wget https://curl.haxx.se/download/curl-7.48.0.tar.gz && \
    tar xf curl-7.48.0.tar.gz && \
    cd curl-7.48.0 && \
    ./configure --with-nghttp2 --enable-libcurl-option --with-ssl=/usr/local/ssl  --enable-static --disable-shared && \
    make && \
    make install

RUN pip install pycurl uwsgi

