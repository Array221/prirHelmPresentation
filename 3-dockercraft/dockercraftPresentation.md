# Dockercraft

- [Link to dockercraft repo](https://github.com/docker/dockercraft)
- [Link to kubecraft repo](https://github.com/stevesloka/kubecraft)

## Starting dockercraft server

```shell
docker run -t -i -d \
    -p 25565:25565 \
    --name dockercraft \
    -v /var/run/docker.sock:/var/run/docker.sock \
    docker/dockercraft
```

## Workaround for non-premium launchers
- Download **settings.ini** file from **non-premium** directory
- Create **config** directory
- Put **settings.ini** in **config** directory
- Run following command:
```shell
docker run -d -t -i \
	-p 25565:25565 \
	--name dockercraft \
	-v /var/run/docker.sock:/var/run/docker.sock \
	-v ./config/settings.ini:/srv/Server/settings.ini \
	docker/dockercraft
```
