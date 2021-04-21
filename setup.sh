#!/bin/zsh

function build()
{
	eval $(minikube docker-env)
    docker build -f srcs/$1/$1.dockerfile -t my-$1 ./srcs/$1/
    kubectl apply -f srcs/$1/$1.yaml
}

function kube()
{
	minikube delete
	minikube start --driver=virtualbox
	IP_MINIKUBE=$(minikube ip)

	kubectl apply -f srcs/mysql/storage_class.yaml
	build mysql
	build nginx
	build phpmyadmin
	build wordpress

	minikube dashboard
}

kube