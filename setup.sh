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
	minikube start
	IP_MINIKUBE=$(minikube ip)

	build mysql
	build nginx
	build phpmyadmin
	build wordpress

	minikube dashboard
}

kube