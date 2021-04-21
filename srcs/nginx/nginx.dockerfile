FROM alpine:3.12

LABEL maintainer="jjourdan@student.42lyon.fr"

RUN apk update && apk upgrade && apk add --no-cache \
										openrc \
										openssl \
										nginx

COPY srcs/nginx.conf /etc/nginx/nginx.conf
COPY srcs/index.html /www/index.html
COPY srcs/setup_nginx.sh .

RUN chmod +x setup_nginx.sh

EXPOSE 80 443

ENTRYPOINT ["sh", "setup_nginx.sh"]