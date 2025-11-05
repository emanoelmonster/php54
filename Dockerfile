FROM centos:7
RUN rm -f /etc/yum.repos.d/*.repo
COPY CentOS-Vault-7.repo /etc/yum.repos.d/CentOS-Vault-7.repo
RUN yum update -y
RUN rm -f /etc/yum.repos.d/*.repo
COPY CentOS-Vault-7.repo /etc/yum.repos.d/CentOS-Vault-7.repo
RUN yum install -y epel-release
RUN yum install -y https://rpms.remirepo.net/enterprise/remi-release-7.rpm
RUN yum install -y \
    openssl-devel \
    libcurl-devel \
    libxml2-devel \
    zlib-devel \
    bzip2-devel \
    libpng-devel \
    freetype-devel \
    gd-devel \
    mysql-devel \
    gmp-devel \
    libxslt-devel \
    libmcrypt-devel \
    libmcrypt \
    impa \
    imap-devel \
    vim \
    mod_ssl \
    php-pdo \
    php-mysql \
    php-mcrypt \
    php-pgsql \
    php-gd \
    php-xml \
    php-mbstring \
    php-imap \
    php-cli \
    php-soap \
    php-devel \
    php-common \
    php \
    php-process \
    php-pecl-apcu-4.0.11-1.el7.x86_64 \
    php-pecl-jsond-devel-1.4.0-1.el7.remi.5.4.x86_64 \
    php-pecl-jsond-1.4.0-1.el7.remi.5.4.x86_64 \
    php-pecl-json-post-1.0.0-2.el7.x86_64 \
    php-pear-1.9.4-23.el7_9.noarch \
    gd3php-2.3.3-7.el7.remi.x86_64

COPY php.ini /etc/php.ini
ADD soa.conf /etc/httpd/conf.d/soa.conf
  EXPOSE 80
CMD ["/usr/sbin/httpd","-DFOREGROUND"]