FROM plutonianbe/php54-apache:latest

RUN printf '%s\n' \
    'deb http://archive.debian.org/debian jessie main contrib non-free' \
    'deb http://archive.debian.org/debian jessie-updates main contrib non-free' \
    'deb http://archive.debian.org/debian-security jessie/updates main contrib non-free' \
    > /etc/apt/sources.list


RUN apt-get -o Acquire::Check-Valid-Until=false update || true
RUN apt -y -q \
  -o Dpkg::Options::=--force-confdef \
  -o Dpkg::Options::=--force-confold \
  -o Acquire::AllowInsecureRepositories=true \
  -o APT::Get::AllowUnauthenticated=true \
  upgrade


  RUN apt -y -q \
    -o Dpkg::Options::=--force-confdef \
    -o Dpkg::Options::=--force-confold \
    -o Acquire::AllowInsecureRepositories=true \
    -o APT::Get::AllowUnauthenticated=true \
    install \
    build-essential autoconf pkg-config \
    libbz2-dev \
    libjpeg-dev \
    libpng-dev \
    libfreetype6-dev \
    libxpm-dev \
    libgmp-dev \
    gettext \
    libpq-dev \
    libxslt1-dev \
    libzip-dev \
    libmcrypt-dev \
    libmhash-dev \
    libkrb5-dev \
    curl ca-certificates git; \
  rm -rf /var/lib/apt/lists/*

RUN docker-php-ext-configure gd \
    --with-freetype-dir=/usr/include/freetype2 \
    --with-jpeg-dir=/usr 
RUN mkdir -p /usr/local/etc/php/conf.d/
RUN docker-php-ext-install \
    bz2 \
    calendar \
    exif \
    gd \
    gettext 

RUN docker-php-ext-install \
    pcntl \
    pdo_pgsql \
    pgsql \
    shmop \
    sockets \
    sysvmsg \
    xsl \
    zip \
    wddx 

RUN docker-php-ext-install mcrypt 


RUN yes "" | pecl install apc-3.1.13 && docker-php-ext-enable apc

ADD 99-hardening.ini /etc/php5/apache2/conf.d/99-hardening.ini