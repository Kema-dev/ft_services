FROM alpine:edge

LABEL maintainer="jjourdan@student.42lyon.fr"

#RUN apk -U upgrade && apk add php7.3-fpm \
#								php7.3-mysql \
#								nginx \
#								openssl \
#								openssh \
#								vim

RUN apk -U upgrade && apk add nginx \
								openssl \
								vim \
								php7-fpm

COPY srcs ./tmp

WORKDIR /tmp/

ENTRYPOINT ["ash", "setup_nginx.sh"]