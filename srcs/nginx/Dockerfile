FROM alpine:latest

ARG IP

LABEL maintainer="jjourdan@student.42lyon.fr"

RUN apk update && apk upgrade && apk add bash \
										openrc --no-cache \
										openssh\
										openssl \
										nginx \
							&& rm -rf /var/cache/apk/*

RUN chown -R root:root /var/www/* \
	&& chmod -R 755 /var/www/*

COPY srcs/nginx.conf /etc/nginx/nginx.conf
COPY srcs/index.html /www/index.html
COPY srcs/setup_nginx.sh .

RUN adduser -D sshuser \
	&& echo "sshuser:password"|chpasswd \
	&& ssh-keygen -A \
	&& yes "" | openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/certs/localhost.key -subj "/C=FR/ST=FRANCE/L=Lyon/O=42 School/OU=jjourdan/CN=localhost" -out /etc/ssl/certs/localhost.crt \
	&& echo 'SALUT A TOUS C EST JJOURDAN' > /etc/motd

RUN chmod +x setup_nginx.sh && ./setup_nginx.sh

EXPOSE 22
EXPOSE 80
EXPOSE 443