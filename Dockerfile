FROM openspug/spug:3.0.5

ENV NODE_VERSION=16.14.2
ENV COMPOSER_HOME=/data/composer

RUN set -ex \
    && yum install -y xz epel-release ca-certificates zip unzip \
    && yum install -y http://rpms.remirepo.net/enterprise/remi-release-7.rpm \
    && update-ca-trust \
    && curl -SLO https://nodejs.org/dist/v${NODE_VERSION}/node-v${NODE_VERSION}-linux-x64.tar.xz \
    && tar -xJf "node-v${NODE_VERSION}-linux-x64.tar.xz" -C /usr/local --strip-components=1 --no-same-owner \
    && rm "node-v${NODE_VERSION}-linux-x64.tar.xz" \
    && npm config set registry https://registry.npmmirror.com \
    && npm config set cache "/data/cache/npm" \
    && npm install -g npm && npm install -g yarn \
    && yarn config set registry https://registry.npmmirror.com --global \
    && yarn config set disturl https://npmmirror.com/dist --global \
    && yarn config set cache-folder "/data/cache/yarn" \
    && yum install -y php80-php-cli php80-php-mbstring php80-php-bcmath php80-php-gd php80-php-gmp php80-php-pdo php80-php-intl php80-php-odbc php80-php-soap php80-php-tidy php80-php-bcmath php80-php-sodium php80-php-xmlrpc php80-php-mysqlnd php80-php-pecl-psr php80-php-pecl-yaml php80-php-pecl-crypto php80-php-pecl-redis5 php80-php-pecl-msgpack php80-php-pecl-swoole4 php80-php-pecl-igbinary php80-php-pecl-memcached \
    && php80 -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php80 composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && rm -f composer-setup.php \
    && ln -s /opt/remi/php80/root/usr/bin/php /usr/bin/php \
    && rm -rf /var/cache/yum/*
