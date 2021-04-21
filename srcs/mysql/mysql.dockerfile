FROM alpine:3.12

LABEL maintainer="jjourdan@student.42lyon.fr"

RUN apk update && apk upgrade && apk add --no-cache \
										openrc \
										mysql \
										mysql-client

COPY srcs/setup_mysql.sh .

RUN chmod +x setup_mysql.sh

COPY srcs/mariadb-server.cnf /etc/my.cnf.d/

EXPOSE 3306

ENTRYPOINT ["sh", "setup_mysql.sh"]