# ft_services
My 42 Lyon's ft_service

Work in progress ...

docker rm mywebserv && docker build -f nginx.dockerfile -t mywebserv . && docker run --name mywebserv -it -p 80:80 -p 443:443 mywebserv