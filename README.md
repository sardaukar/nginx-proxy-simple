# nginx-proxy-simple

Simple way to have traffic forwarded to an IP on your LAN. Based on [docker-nginx-redirect].

## Why

I started using [seelf] for hosting my Docker compose apps, but I needed to redirect some domain names to services running on internal IPs. In the past, I had this with Traefik:

```
http:
  routers:
    dsm:
      rule: "Host(`dsm.my.domain.name`)"
      service: synology-dsm
      entrypoints:
        - "https"
      tls:
        certResolver: gandi
        domains:
          - main: "my.domain.name"
            sans:
              - "*.my.domain.name"

  services:
    synology-dsm:
      loadBalancer:
        servers:
          - url: http://192.168.1.12:5000
        passHostHeader: "true"
```

With seelf, I don't need to set the domain name (the app's name comes from the application you create) or manage the certificate, but I still needed a way for "non-compose" apps to be exposed, so this Docker image fixes that.

Just create a new app in seelf with the subdomain name you want to use (in this case, `dsm`), and then set the environment for the `nginx` service to, mirroring the above example with Traefik:

```
SERVER_NAME=dsm.my.domain.name
PROXY_TARGET_IP=192.168.1.12
PROXY_TARGET_PORT=5000
PROXY_PROTO=http
```

And set the deployment to:

```
services:
  nginx:
    image: sardaukar/nginx-proxy-simple
    ports:
      - "8888:80"
```

And it should just work. Kudos to [Tobias Munk] for the basics of how to pull this off.

[docker-nginx-redirect]: https://github.com/schmunk42/docker-nginx-redirect
[seelf]: https://github.com/YuukanOO/seelf
[Tobias Munk]: https://github.com/schmunk42
