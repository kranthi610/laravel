From ubuntu

RUN apt-get -y update

RUN apt-get install -y software-properties-common

RUN  add-apt-repository ppa:ondrej/php

RUN apt-get -y update

RUN apt-get install -y nginx

RUN apt-get install -y  curl

ADD . /var/www/html

RUN chown -R www-data:www-data /var/www/html

ADD default.conf /etc/nginx/sites-enabled/default

RUN apt-get install  php7.4 php7.4-fpm php7.4-cli php7.4-xml php7.4-gd php7.4-mysql php7.4-curl php7.4-mbstring zip unzip php7.4-zip -y

RUN chmod -R 777 /var/www/html/bootstrap

RUN chmod -R 777 /var/www/html/storage

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN composer update -d /var/www/html

ADD /home/env/.env /var/www/html

RUN chmod -R 777 /var/www/html/storage

RUN chmod -R 777 /var/www/html/bootstrap 

RUN php /var/www/html/artisan key:generate

RUN chmod -R 775 /var/www/html/

ENTRYPOINT service nginx restart && service php7.4-fpm stop && service php7.4-fpm start && /bin/bash

# docker build -t image_name:1.0 .
# docker run -p 8080:80 -dit --restart=unless-stopped -v /folder:/folder -v /folder:/folder --name continaer_name image_name

# nginx logs, laravel folder, php logs
