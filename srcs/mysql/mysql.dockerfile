FROM alpine:edge

LABEL maintainer="jjourdan@student.42lyon.fr"

RUN apk -U upgrade && apk add php7-mysql \
								vim

COPY srcs ./tmp

WORKDIR /tmp/

ENTRYPOINT ["ash", "setup_mysql.sh"]