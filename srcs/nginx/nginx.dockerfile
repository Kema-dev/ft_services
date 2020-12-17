FROM alpine:latest

LABEL maintainer="jjourdan@student.42lyon.fr"

#RUN apk -U upgrade && apk add php7.3-fpm \
#								php7.3-mysql \
#								nginx \
#								openssl \
#								openssh \
#								vim

RUN apk -U upgrade && apk add nginx \
								openrc \
								openssl

COPY srcs ./tmp

WORKDIR /tmp/

ENTRYPOINT ["ash", "setup_nginx.sh"]