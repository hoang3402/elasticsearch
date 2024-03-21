#
# Elasticsearch Dockerfile
#
# https://github.com/dockerfile/elasticsearch
#

# Pull base image.
FROM docker.elastic.co/elasticsearch/elasticsearch:8.12.2

ENV discovery.type="single-node"

COPY --chown=elasticsearch:elasticsearch elasticsearch.yml /usr/share/elasticsearch/config/

# Define mountable directories.
VOLUME ["/data"]

# Define working directory.
WORKDIR /data

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300

CMD ["elasticsearch"]