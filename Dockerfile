##### building stage #####
FROM python:3.10 as builder

RUN apt-get update && apt-get install -y \
    unzip 

# firefox driver
ADD https://github.com/mozilla/geckodriver/releases/download/v0.31.0/geckodriver-v0.31.0-linux64.tar.gz /opt/firefox/
RUN cd /opt/firefox/ && \
    tar zxvf geckodriver-v0.31.0-linux64.tar.gz && \
    rm -f geckodriver-v0.31.0-linux64.tar.gz

# python package
RUN pip install --upgrade pip
COPY requirements.txt .
RUN pip install --no-cache-dir -r  requirements.txt


##### production stage #####
FROM python:3.10-slim
COPY --from=builder /opt/ /opt/
COPY --from=builder /usr/local/lib/python3.10/site-packages /usr/local/lib/python3.10/site-packages
COPY 51-local.conf.patch /tmp
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    git \
    gnupg \
    patch \
    locales \
    fonts-takao-gothic && \
    mv /opt/firefox/geckodriver /usr/local/bin && \
    pip install bs4 oauth2client google-api-python-client

# firefox
RUN apt-get update && \
    apt-get install -y \
    firefox-esr firefox-esr-l10n-ja && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    locale-gen ja_JP.UTF-8 && \
    localedef -f UTF-8 -i ja_JP ja_JP 
#    Windowsのフォントを使用する場合に実施
#    cd /usr/share/fontconfig/conf.avail/ && patch -p1 < /tmp/51-local.conf.patch 
    
ENV DISPLAY host.docker.internal:0.0
ENV LANG ja_JP.UTF-8
ENV LANGUAGE ja_JP:jp
ENV LC_ALL ja_JP.UTF-8

WORKDIR /work

ENV PATH /usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/opt/chrome

