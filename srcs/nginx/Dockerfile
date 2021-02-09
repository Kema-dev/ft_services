FROM alpine

ARG IP

LABEL maintainer="jjourdan@student.42lyon.fr"

RUN apk update && apk upgrade && apk add bash \
										openrc --no-cache \
										openssh\
										openssl \
										nginx

RUN chown -R root:root /var/www/* \
	&& chmod -R 755 /var/www/*

COPY srcs/nginx.conf /etc/nginx/nginx.conf
COPY srcs/index.html /www/index.html
COPY srcs/setup_nginx.sh .

RUN adduser -D \
	&& echo 'SALUT A TOUS C EST JJOURDAN' > /etc/motd

RUN chmod +x setup_nginx.sh && ./setup_nginx.sh

EXPOSE 22
EXPOSE 80
EXPOSE 443