FROM alpine

ARG IP

LABEL maintainer="jjourdan@student.42lyon.fr"

RUN apk update && apk upgrade && apk add bash \
										php7 \
										php7-fpm \
										php7-opcache \
										php7-gd \
										php7-mysqli \
										php7-zlib \
										php7-curl \
										php7-mbstring \
										php7-json \
										php7-session

RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz \
	&& tar -xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz \
	&& mv phpMyAdmin-4.9.0.1-all-languages /www \
	&& rm -rf /var/cache/apk/* \
	&& echo $IP > ip.txt

COPY srcs/phpmyadmin.inc.php /www/config.inc.php
COPY srcs/setup_phpmyadmin.sh .

RUN chmod +x setup_phpmyadmin.sh && ./setup_phpmyadmin.sh

EXPOSE 5000