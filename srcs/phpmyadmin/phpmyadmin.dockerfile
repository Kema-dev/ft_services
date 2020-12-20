FROM alpine:edge

LABEL maintainer="jjourdan@student.42lyon.fr"

RUN apk -U upgrade && apk add php7-fpm \
								nginx \
								openssl \
								phpmyadmin \
								#mysql \
								#mysql-client \
								#php-mysqli \
								vim

COPY srcs ./tmp

WORKDIR /tmp/

ENTRYPOINT ["ash", "setup_phpmyadmin.sh"]