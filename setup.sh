#!/bin/sh

#minikube --vm-driver=docker start --extra-config=apiserver.service-node-port-range=1-35000
minikube --vm-driver=virtualbox start --extra-config=apiserver.service-node-port-range=1-35000

minikube addons enable ingress
minikube addons enable dashboard

minikube dashboard &

eval $(minikube docker-env)

#IP=$(minikube ip)
IP=$(kubectl get node -o=custom-columns='DATA:status.addresses[0].address' | sed -n 2p)
printf "Minikube IP: ${IP}"

docker build -t service_nginx ./srcs/nginx
docker build -t service_mysql ./srcs/mysql --build-arg IP=${IP}
docker build -t service_wordpress ./srcs/wordpress --build-arg IP=${IP}
docker build -t service_phpmyadmin ./srcs/phpmyadmin --build-arg IP=${IP}

kubectl create -f ./srcs/

open http://$IP