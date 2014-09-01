#!/bin/bash

sudo apt-get install nginx -y
sudo apt-get install curl -y
sudo apt-get install default-jre -y
curl -O https://download.elasticsearch.org/logstash/logstash/logstash-1.4.2.tar.gz

if [ ! -f "kibana-3.1.0.tar.gz" ]; then
  wget -q https://download.elasticsearch.org/kibana/kibana/kibana-3.1.0.tar.gz 
  gzip -d kibana-3.1.0.tar.gz
  tar -xvf kibana-3.1.0.tar
fi

cd kibana-3.1.0
sudo sed -i 's/"+window.location.hostname+"/192.168.33.10/g' config.js
