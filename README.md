Docker-Script to create a simple, interactive Docker container for a complete ELK-Stack with [Elasticsearch 2.1.1](http://www.elasticsearch.com/products/elasticsearch/) / [Logstash 2.1.1](http://www.elasticsearch.com/products/logstash/) / [Kibana 4.3.1](http://www.elasticsearch.com/products/kibana/) / [Sense](https://github.com/elastic/sense).

![Kibana - Marvel - Sense](kibana.png)

# Setup
```
--------------     --------------     --------------     --------------     --------------
|  Logstash  |     |            |     | Logstash   |     |  Elastic   |     |            |
|            | ==> |    Redis   | ==> |            | ==> |            | ==> |   Kibana   |
|  Shipper   |     |            |     | Indexer    |     |  Search    |     |            |
--------------     --------------     --------------     --------------     --------------
```

# Building the Container
```
docker build -t=kibana .
```

# Running the Container

```
docker run -i -t -p 5601:5601 -p 80:80 kibana
```
## Services on the Container
After the `startup`-Script, the following services are available:
- [Kibana](http://192.168.99.100:5601/app/kibana)
- [Marvel](http://192.168.99.100:5601/app/marvel)
- [Sense](http://192.168.99.100:5601/app/sense)
- [Bootstrap sample page from startbootstrap.com](http://192.168.99.100)

# Usage
Entries in the `syslog` and the `nginx-access` log will be processed by logstash and stored in elasticsearch. You can add log-entries to the `syslog` with `logger` eg.

```
logger FINDME
```
Or you can visit the [Bootstrap Sample Page](http://192.168.99.100) to create Nginx Access Logs.
