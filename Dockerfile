#
# Elasticsearch Dockerfile
#
# https://github.com/dockerfile/elasticsearch
#

# Pull base image.
FROM docker.elastic.co/elasticsearch/elasticsearch:8.12.2
COPY --chown=elasticsearch:elasticsearch config/elasticsearch.yml /usr/share/elasticsearch/config/

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300
