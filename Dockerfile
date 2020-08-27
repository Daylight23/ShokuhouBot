#
# NOTE: THIS DOCKERFILE IS GENERATED VIA "update.sh"
#
# PLEASE DO NOT EDIT IT DIRECTLY.
#

FROM alpine:3.12

# http://bugs.python.org/issue19846
# > At the moment, setting "LANG=C" on a Linux system *fundamentally breaks Python 3*, and that's not OK.
ENV LANG C.UTF-8

# install ca-certificates so that HTTPS works consistently
# other runtime dependencies for Python are installed later
RUN apk add --no-cache ca-certificates

ENV GPG_KEY E3FF2839C048B25C084DEBE9B26995E310250568
ENV PYTHON_VERSION 3.8.5

RUN set -ex \
	&& apk add --no-cache --virtual .build-deps  \
		bash \
        bzip2 \
        curl \
        figlet \
        git \
        util-linux \
        libffi-dev \
        libjpeg-dev \
        libjpeg62-turbo-dev \
        libwebp-dev \
        linux-headers-amd64 \
        musl-dev \
        musl \
        neofetch \
        php-pgsql \
        python3-lxml \
        postgresql \
        postgresql-client \
        python3-psycopg2 \
        libpq-dev \
        libcurl4-openssl-dev \
        libxml2-dev \
        libxslt1-dev \
        python3-pip \
        python3-requests \
        python3-sqlalchemy \
        python3-tz \
        python3-aiohttp \
        openssl \
        pv \
        jq \
        wget \
        python3 \
        python3-dev \
        libreadline-dev \
        libyaml-dev \
        gcc \
        sqlite3 \
        libsqlite3-dev \
        sudo \
        zlib1g \
        ffmpeg \
        libssl-dev \
        libgconf-2-4 \
        libxi6 \
        xvfb \
        unzip \
        libopus0 \
        libopus-dev \
# Pypi package Repo upgrade
RUN pip3 install --upgrade pip setuptools
RUN apk add git

# Copy Python Requirements to /root/ShokuhouBot
RUN git clone https://github.com/Dank-del/ShokuhouBot /root/ShokuhouBot
WORKDIR /root/ShokuhouBot

#Copy config file to /root/ShokuhouBot/misaki
COPY ./misaki/sample_config.py ./misaki/config.py* /root/ShokuhouBot/misaki/

ENV PATH="/home/bot/bin:$PATH"

# Install requirements
RUN pip3 install -U -r requirements.txt

# Starting Worker
CMD ["python3","-m","misaki"]