FROM alpine:edge

LABEL maintainer="jjourdan@student.42lyon.fr"

RUN apk -U upgrade && apk add nginx \
								openssl \
								vim \
								php7-fpm

RUN php-fpm7

COPY srcs ./tmp

WORKDIR /tmp/

ENTRYPOINT ["ash", "setup_nginx.sh"]