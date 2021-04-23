FROM alpine:3.12

LABEL maintainer="jjourdan@student.42lyon.fr"

RUN apk update && apk upgrade && apk add --no-cache \
										openrc \
										openssl \
										nginx \
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
										wget \
										curl \
										vim \
										sudo

COPY srcs/nginx.conf /etc/nginx/nginx.conf
COPY srcs/index.html /www/index.html
COPY srcs/setup_nginx.sh .

COPY srcs/wp-config.php /www/wp-config.php
COPY srcs/setup_wordpress.sh .

RUN wget https://fr.wordpress.org/wordpress-5.7.1-fr_FR.tar.gz > /dev/null 2>&1 && \
	tar -xvf wordpress-5.7.1-fr_FR.tar.gz > /dev/null 2>&1 && \
	mkdir -p /www/wordpress && \
	mv wordpress/* /www/wordpress/

RUN chmod +x setup_wordpress.sh
RUN chmod +x setup_nginx.sh

COPY srcs/wp-config.php /www/worpress

EXPOSE 5050

ENTRYPOINT ["sh", "setup_wordpress.sh"]