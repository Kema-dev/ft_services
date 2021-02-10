FROM alpine:latest

ARG IP

LABEL maintainer="jjourdan@student.42lyon.fr"

RUN apk update && apk upgrade && apk add bash \
										mariadb \
										mariadb-client \
							&& rm -rf /var/cache/apk/*

COPY srcs/setup_docker.sh .
COPY srcs/setup_db.sh .
COPY srcs/setup_mysql.sh .

RUN chmod +x setup_docker.sh \
	&& chmod +x setup_db.sh \
	&& chmod +x setup_mysql.sh && ./setup_mysql.sh

EXPOSE 3306