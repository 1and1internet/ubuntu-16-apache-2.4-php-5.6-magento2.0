FROM 1and1internet/ubuntu-16-apache-2.4-php-5.6:latest
MAINTAINER james.wilkins@fasthosts.co.uk
ARG DEBIAN_FRONTEND=noninteractive
COPY files /
RUN \
    apt-get update && \
    apt-get install -y php5.6-mcrypt php5.6-intl php5.6-mbstring bzip2 && \
    sed -i -e 's/;always_populate_raw_post_data = -1/always_populate_raw_post_data = -1/g' /etc/php/5.6/apache2/php.ini && \
    sed -i -e 's/max_execution_time = 30/max_execution_time = 360/g' /etc/php/5.6/apache2/php.ini && \
    sed -i -e 's/memory_limit = 128M/memory_limit = 768M/g' /etc/php/5.6/apache2/php.ini && \
    cd /usr/src && curl -O http://mirror.paas.fasthosts.net.uk/docker/Magento-CE-2.0.5+sample_data-2016-04-28-02-16-15.tar.bz2 && \
    rm -rf /var/lib/apt/lists/* && \
    chmod 755 /hooks /init
EXPOSE 8080
ENV MYSQL_USER=magento \
    MYSQL_PASSWORD=EnvVarHere \
    MYSQL_DATABASE=magento \
    MYSQL_HOST=mysql

