#
# Elasticsearch Dockerfile
#
# https://github.com/dockerfile/elasticsearch
#

# Pull base image.
FROM sgrio/java:server_jre_8_alpine

ENV ES_PKG_NAME elasticsearch-8.12.2

WORKDIR /

# Install Elasticsearch.
RUN \
  cd / && \
  wget https://artifacts.elastic.co/downloads/elasticsearch/$ES_PKG_NAME-linux-x86_64.tar.gz && \
  tar xzf $ES_PKG_NAME-linux-x86_64.tar.gz && \
  rm -f $ES_PKG_NAME-linux-x86_64.tar.gz && \
  mv $ES_PKG_NAME /elasticsearch && \
  ls

# Mount elasticsearch.yml config
ADD elasticsearch.yml /elasticsearch/config/elasticsearch.yml

RUN cd / && \
  cd /elasticsearch/bin && \
  ./elasticsearch

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300