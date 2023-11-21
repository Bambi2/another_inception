FROM alpine:3.18

# Arguments for building
ARG USERNAME
ARG MARIADB_USER_PWD
ARG MARIADB_HOST


# Downloading all the php stuff + configuring port
# TODO: maybe we don't need to set the listen owner and group
RUN apk update && apk upgrade && apk add --no-cache \
    php8 \
    php8-fpm \
    php8-mysql \
    wget \
    unzip \
    sed -i "s|listen = 127.0.0.1:9000|listen = 9000|g" \
    /etc/php8/php-fpm.d/www.conf \
    sed -i "s|;listen.owner = nobody|listen.owner = nobody|g" \
    /etc/php8/php-fpm.d/www.conf \
    sed -i "s|;listen.group = nobody|listen.group = nobody|g" \
    /etc/php8/php-fpm.d/www.conf \
    && rm -f /var/cache/apk/*

# Default web directory
WORKDIR /var/www

# Downloading and extracting wordpress
RUN wget https://wordpress.org/wordpress-6.4.1.zip && \
    unzip latest.zip && \
    cp -rf wordpress/* . && \
    rm -rf wordpress latest.zip

# Copying configurating script
COPY .conf/wp-config-create.sh .

# Running the script
RUN sh wp-config-create.sh && rm wp-config-create.sh && \
    chmod -R 0777 wp-content/

CMD ["/usr/sbin/php-fpm8", "-F"]