#!/bin/bash

################################################################################
# Author : Awais Khan                                                          #
# Use this script as a root user.                                              #
# This script is used to create a Node exporter service for prometheus         #
# the service will use port 9100 by default                                    #
################################################################################

which wget tar 
if [ $? == 1 ];then
printf "\n  Make sure that you have these dependencies installed :

    tar , wget
"
else
useradd -m -s /bin/bash node_exporter
wget https://github.com/prometheus/node_exporter/releases/download/v0.18.1/node_exporter-0.18.1.linux-amd64.tar.gz
tar -xf node_exporter-0.18.1.linux-amd64.tar.gz

cp node_exporter-0.18.1.linux-amd64/node_exporter /usr/local/bin

cat <<EOF >/etc/systemd/system/node_exporter.service

[Unit]
Description=Node Exporter
Wants=network-online.target
After=network-online.target

[Service]
User=node_exporter
ExecStart=/usr/local/bin/node_exporter

[Install]
WantedBy=default.target


EOF

systemctl daemon-reload
systemctl start node_exporter
systemctl enable node_exporter

fi


