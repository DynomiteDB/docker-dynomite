# Dynomite runtime container

The `dynomite` container provides a clean, reusable and immutable runtime environment for the Dynomite server.

# What is Dynomite?

Dynomite is a framework that turns single server databases into scalable, distributed databases. 

Specifically, Dynomite is a Dynamo-inspired layer that provides sharding, replication, a gossiper, a partitioner and other shared database infrastructure. 

DynomiteDB currently provides the Redis API for accessing both in-memory and persistent backends. A common API allows you to reuse queries, data models and knowledge across both traditional database and caching workloads.

DynomiteDB currently supports the following pluggable backends:

- Redis: Big data cache for in-memory workloads
- LMDB: Traditional database (persistent storage) for high performance workloads
- RocksDB: Traditional database (persistent storage) for big data workloads on SSD
- LevelDB: Traditional database (persistent storage) for big data workloads on hard drives (i.e. spinning disks)

# How to use this image

## Start a `dynomite` instance
```bash
docker run --name dynomite --net=host -d -p 8102:8102 -p 8101:8101 dynomitedb/dynomite
```

## Use a custom `dynomite.yaml` configuration file

You can provide Dynomite with a custom configuration file as show below. In this example, we first clone a git repository that has a custom `dynomite.yaml` file.

> If you plan to use a custom configuration file, then stop and delete the `dynomite` container if you previously ran the command above. `docker stop dynomite`, then `docker rm dynomite`.

```bash
mkdir -p ~/repos && cd $_

git clone https://github.com/DynomiteDB/docker-custom-conf-files.git

cd docker-custom-conf-files

docker run --name dynomite --net=host -d -p 8102:8102 -p 8101:8101 -v ${PWD}/dynomite.yaml:/etc/dynomitedb/dynomite.yaml dynomitedb/dynomite
```

# License

[View Apache 2.0 license](https://github.com/DynomiteDB/docker-dynomite/blob/master/LICENSE)

# Manually build the `build-dynomite` image

The `dynomite` Docker image is automatically built via DockerHub at https://hub.docker.com/r/dynomitedb/dynomite.

The instructions below allow you to manually build the `dynomite` image, if required.

Clone the `docker-dynomite` repo from Github.

```bash
mkdir -p ~/repos/ && cd $_

git clone https://github.com/DynomiteDB/docker-dynomite.git
```

`cd` into the `docker-dynomite` directory.

```bash
cd ~/docker-dynomite
```

Create the `dynomite` image.

```bash
docker build -t dynomitedb/dynomite .
```

