FROM alpine:latest

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
										php7-session \
							&& rm -rf /var/cache/apk/*

RUN wget https://wordpress.org/latest.tar.gz \
	&& tar -xvf wget https://wordpress.org/latest.tar.gz \
	&& mv wordpress/* /www \
	&& rm -rf /var/cache/apk/* \
	&& echo $IP > ip.txt

COPY srcs/wp-config.php /www/wp-config.php
COPY srcs/setup_wordpress.sh .

RUN chmod +x setup_wordpress.sh && ./setup_wordpress.sh

EXPOSE 5050