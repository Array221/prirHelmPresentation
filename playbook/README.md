# Playbook that prepares server for presentation

## Downloading required roles
```shell
ansible-galaxy role install \
    -p ./roles \
    array221.clearbox \
    geerlingguy.docker \
    pandemonium1986.minikube \
    pandemonium1986.kubectl \
    pandemonium1986.kubectx \
    pandemonium1986.helm
```

## Creating inventory.yml file from template
```shell
cp inventory.example.yml inventory.yml
```
Then you should change values in **inventory.yml** values to your own.

## Running playbook
```shell
./run.yml
```
or, if you have password authentication enabled:
```shell
./run.yml -k
```
