#
# Elasticsearch Dockerfile
#
# https://github.com/dockerfile/elasticsearch
#

# Pull base image.
FROM sgrio/java:server_jre_8_alpine

ENV ES_PKG_NAME elasticsearch-8.12.2

# Install Elasticsearch.
RUN \
  cd / && \
  wget https://artifacts.elastic.co/downloads/elasticsearch/$ES_PKG_NAME-linux-x86_64.tar.gz && \
  tar xvzf $ES_PKG_NAME-linux-x86_64.tar.gz && \
  rm -f $ES_PKG_NAME-linux-x86_64.tar.gz && \
  mv /$ES_PKG_NAME-linux-x86_64 /elasticsearch

# Define mountable directories.
VOLUME ["/data"]

# Mount elasticsearch.yml config
ADD elasticsearch.yml /elasticsearch/config/elasticsearch.yml

# Define working directory.
WORKDIR /data

# Define default command.
CMD ["/elasticsearch/bin/elasticsearch"]

# Expose ports.
#   - 9200: HTTP
#   - 9300: transport
EXPOSE 9200
EXPOSE 9300