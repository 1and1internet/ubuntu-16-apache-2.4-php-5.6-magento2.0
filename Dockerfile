FROM 1and1internet/ubuntu-16-apache-php-5.6:latest
MAINTAINER james.wilkins@1and1.co.uk
ARG DEBIAN_FRONTEND=noninteractive
COPY files /
RUN \
    apt-get update && \
    apt-get install -y php5.6-mcrypt php5.6-mbstring php5.6-curl php5.6-cli php5.6-mysql php5.6-gd php5.6-intl php5.6-xsl bzip2 && \
    sed -i -e 's/;always_populate_raw_post_data = -1/always_populate_raw_post_data = -1/g' /etc/php/5.6/apache2/php.ini && \
    sed -i -e 's/max_execution_time = 30/max_execution_time = 18000/g' /etc/php/5.6/apache2/php.ini && \
    sed -i -e 's/memory_limit = 128M/memory_limit = 2G/g' /etc/php/5.6/apache2/php.ini && \
    echo >>/etc/apache2/apache2.conf "EnableSendfile Off" && \
    echo >>/etc/apache2/apache2.conf "EnableMMAP Off" && \
    cd /usr/src && curl -O http://mirror.fhpaas.fasthosts.net.uk/docker/Magento-CE-2.1.0-2016-06-23-02-28-50.tar.bz2 && \
    rm -rf /var/lib/apt/lists/* && \
    chmod 755 /hooks /init
EXPOSE 8080
ENV MYSQL_USER=magento \
    MYSQL_PASSWORD=EnvVarHere \
    MYSQL_DATABASE=magento \
    MYSQL_HOST=mysql
