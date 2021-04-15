FROM alpine:edge

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
										php7-session

RUN wget https://files.phpmyadmin.net/phpMyAdmin/4.9.0.1/phpMyAdmin-4.9.0.1-all-languages.tar.gz && \
	tar -xvf phpMyAdmin-4.9.0.1-all-languages.tar.gz > /dev/null 2>&1 && \
	mkdir -p /www/phpmyadmin && \
	mv phpMyAdmin-4.9.0.1-all-languages/* /www/phpmyadmin/

COPY srcs/nginx.conf /etc/nginx/nginx.conf
COPY srcs/index.html /www/index.html
COPY srcs/setup_nginx.sh .

COPY srcs/phpmyadmin.inc.php /www/phpmyadmin/config.inc.php
COPY srcs/setup_phpmyadmin.sh .

RUN chmod +x setup_phpmyadmin.sh
RUN chmod +x setup_nginx.sh

COPY srcs/phpmyadmin.inc.php /www/phpmyadmin

EXPOSE 5000

ENTRYPOINT ["sh", "setup_phpmyadmin.sh"]
