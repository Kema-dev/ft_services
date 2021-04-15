FROM alpine:edge

LABEL maintainer="jjourdan@student.42lyon.fr"

RUN apk update && apk upgrade && apk add openrc --no-cache \
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
										php7-session

#RUN wget https://wordpress.org/wordpress-5.6.tar.gz
#
#RUN tar -xvf latest-fr_FR.tar.gz && \
#	mkdir -p /www/wordpress/ \
#	mv latest-fr_FR/* /www/wordpress/ && \
#	rm -rf /var/cache/apk/*

COPY srcs/nginx.conf /etc/nginx/nginx.conf
COPY srcs/index.html /www/index.html
COPY srcs/setup_nginx.sh .

COPY srcs/wp-config.php /www/wp-config.php
COPY srcs/setup_wordpress.sh .

RUN chmod +x setup_wordpress.sh
RUN chmod +x setup_nginx.sh

EXPOSE 80 443 5000 5050

ENTRYPOINT ["sh", "setup_wordpress.sh"]