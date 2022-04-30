# LGTM - Open Source Monitoring with Loki, Grafana, Tempo, and Mimir.

This is the demo for my talk at the [JBCNConf 2022](https://www.jbcnconf.com/2022/infoSpeaker.html?ref=83000b23dafd750a87d9e4fda12b906fc1e4e734).

## Slides

[docs.google.com](https://docs.google.com/presentation/d/e/2PACX-1vRIX3tZFSElD-DnKOGa4UrG71-BpE-NQTEhEPkxW9VY4S_jhviqCfQBBpubKiEBmxQzehkrFVaNJECT/pub?start=false&loop=false&delayms=3000)

## Run the Demo on your Laptop

```
./install-all.sh
./run-all.sh
```

Grafana will be available on [http://localhost:3000](http://localhost:3000). Default user is _admin_ with password _admin_.

## Run the Demo in Docker

I also pushed a Docker image with the demo to [dockerhub](https://hub.docker.com/repository/docker/fstab/jbcn.conf-2022). You can run it as follows:

```
docker run --rm -p 3000:3000 -p 8080:8080 -p 8081:8081 -p 9464:9464 -p 9465:9465 -p 9009:9009 -ti fstab/jbcn.conf-2022
```

Grafana will be available on [http://localhost:3000](http://localhost:3000). Default user is _admin_ with password _admin_.
