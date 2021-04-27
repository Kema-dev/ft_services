#!/bin/zsh
function build()
{
	eval $(minikube docker-env)
    docker build -f srcs/$1/$1.dockerfile -t my-$1 ./srcs/$1/
    kubectl apply -f srcs/$1/$1.yaml
}

function kube()
{
	timer=${timer:-$SECONDS}
	echo "\xF0\x9F\x98\xAD \e[1m\e[94m" Let\'s start ft_services "\e[0m"

	minikube delete
	minikube start --driver=virtualbox
	IP_MINIKUBE=$(minikube ip)

	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/namespace.yaml
	kubectl apply -f https://raw.githubusercontent.com/metallb/metallb/v0.9.6/manifests/metallb.yaml
	kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
	sed -e "s/MINIKUBE_IP/$IP_MINIKUBE/g" srcs/metallb/bare_metallb.yaml > srcs/metallb/metallb.yaml
	kubectl apply -f srcs/metallb/metallb.yaml
	kubectl apply -f srcs/mysql/storage_class.yaml

	build mysql
	build nginx
	build phpmyadmin
	build wordpress

	echo "\xF0\x9F\x98\xAD \e[1m\e[94m" It took $(($SECONDS - $timer)) seconds to start all services "\e[0m"
	unset timer

	minikube dashboard
}

kube