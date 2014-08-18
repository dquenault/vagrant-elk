#!/bin/bash

sudo apt-get install default-jre -y

if [ ! -f "elasticsearch-1.3.2.tar.gz" ]; then
  wget -q https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-1.3.2.tar.gz
  gzip -d elasticsearch-1.3.2.tar.gz
  tar -xvf elasticsearch-1.3.2.tar
fi

sudo ./elasticsearch-1.3.2/bin/elasticsearch &

