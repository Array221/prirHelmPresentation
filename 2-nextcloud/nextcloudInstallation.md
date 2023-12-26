# Nextcloud installation using helm

## Starting minikube container
```shell
minikube start
```

## Adding repo and updating helm cache
```shell
helm repo add nextcloud https://nextcloud.github.io/helm/
helm repo update
```

## Getting file with default values
```shell
mkdir nextcloud
cd nextcloud
helm inspect values nextcloud/nextcloud > values.yml
```

## Editing values
- **ingress.enabled: true**
- **nextcloud.host: &lt;domain>**

## Enabling ingress addon in minikube
```shell
minikube addons enable ingress
```

## Installing chart
```shell
helm install prirnc nextcloud/nextcloud -f values.yml
```

## Exposing minikube ports by opening tunnel
```shell
minikube tunnel --bind-address=$(curl ip.me)
```
