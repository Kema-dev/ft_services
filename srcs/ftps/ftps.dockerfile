FROM alpine:3.12

LABEL maintainer="jjourdan@student.42lyon.fr"

RUN apk update && apk upgrade && apk add --no-cache \
										openrc \
										openssl \
										vsftpd \
										curl \
										vim \
										sudo

COPY srcs/setup_ftps.sh .

RUN chmod +x setup_ftps.sh

EXPOSE 21

ENTRYPOINT ["sh", "setup_ftps.sh"]