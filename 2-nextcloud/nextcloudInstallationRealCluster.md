# Nextcloud installation on real Kubernetes cluster

## Ingress

### Adding repo
```shell
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
```

### Creating values file (**values.ingress-nginx.yml**)
```yml
controller:
  service:
    externalIPs:
      - <IPaddress>
```

### Chart deployment
```shell
helm upgrade \
  --install ingress-nginx \
  ingress-nginx/ingress-nginx \
  -f values.ingress-nginx.yml \
  --namespace ingress-nginx --create-namespace
```

**IMPORTANT:** *Wait until controller pod is running. Otherwise nextcloud will throw some errors.*


## Nextcloud

### Adding repo
```shell
helm repo add nextcloud https://nextcloud.github.io/helm/
helm repo update
```

### Creating values file (**values.nextcloud.yml**)
```yml
nextcloud:
  host: <DomainName>

cronjob:
  enabled: true

ingress:
  enabled: true
  className: nginx
  annotations:
    nginx.ingress.kubernetes.io/proxy-body-size: 4G
    nginx.ingress.kubernetes.io/server-snippet: |-
      server_tokens off;
      proxy_hide_header X-Powered-By;
      rewrite ^/.well-known/webfinger /index.php/.well-known/webfinger last;
      rewrite ^/.well-known/nodeinfo /index.php/.well-known/nodeinfo last;
      rewrite ^/.well-known/host-meta /public.php?service=host-meta last;
      rewrite ^/.well-known/host-meta.json /public.php?service=host-meta-json;
      location = /.well-known/carddav {
        return 301 $scheme://$host/remote.php/dav;
      }
      location = /.well-known/caldav {
        return 301 $scheme://$host/remote.php/dav;
      }
      location = /robots.txt {
        allow all;
        log_not_found off;
        access_log off;
      }
      location ~ ^/(?:build|tests|config|lib|3rdparty|templates|data)/ {
        deny all;
      }
      location ~ ^/(?:autotest|occ|issue|indie|db_|console) {
        deny all;
      }
  labels: {}
  path: /
  pathType: Prefix
```

### Chart deployment
```shell
helm upgrade \
  --install nextcloud \
  nextcloud/nextcloud \
  -f values.nextcloud.yml \
  --namespace nextcloud --create-namespace
```
