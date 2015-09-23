# Imagen para generar instancias de Redis que sirvan como nodos para Redis Cluster

## Uso

```
docker run -p 7001:6379 -p 17001:16379 karmapulse/redis-node
```

De esta manera generaremos una instancia de Redis configurada para funcionar como nodo de cluster. La distribucion de carpetas queda de la siguiente manera:

- **/redis-stable**: Contiene todos los archivos de instalacion de Redis. El contenido de la carpeta es el mismo que [aqui](http://download.redis.io/releases/redis-stable.tar.gz) mas una carpeta para alojar los logs y backups.
- **/redis-stable/log**: Aqui se almacenan todos los logs generados por la instancia.
- **/redis-stable/backups**: Contiene todos los archivos de backup generados por la instancia.
- **/conf**: Contiene el archivo redis.conf usado para levantar la instancia de Redis.

Es conveniente tener acceso en cualquier momento a los logs de la instancia, de igual manera es deseable que nuestros backups persistan, para lograr esto podemos ligarlos a un volumen en nuestro host.
```
docker run -p 7001:6379 -p 17001:16379 -v /host/redis_node/log/redis-stable/log:/redis-stable/log/ -v /host/redis_node/log/redis-stable/backups:/redis-stable/backups karmapulse/redis-node
```

Si deseamos tener control sobre el archivo redis.conf y poder modificarlo sin tener que contruir la imagen cada vez, podemos de igual manera exponerlo a un volumen que contenga nuestro propio archivo redis.conf o una copia de [este](https://github.com/KarmaPulse/docker-redis-cluster-node/blob/master/conf/redis.conf).

```
docker run -p 7001:6379 -p 17001:16379 -v /host/redis-node/conf:/conf/ karmapulse/redis-node
```
Donde /host/redis-node/conf es una carpeta con un archivo redis.conf dentro.
