#!/bin/bash

################################################################################
# Author : Awais Khan                                                          #
# Use this script as a root user.                                              #
# This script is used to create an Apache exporter service for prometheus      #
# the service will use port 9117 by default                                    #
################################################################################
export VER="0.5.0"

wget https://github.com/Lusitaniae/apache_exporter/releases/download/v${VER}/apache_exporter-${VER}.linux-amd64.tar.gz
tar xvf apache_exporter-${VER}.linux-amd64.tar.gz 
cp apache_exporter-${VER}.linux-amd64/apache_exporter /usr/local/bin
groupadd --system apache_exporter
useradd -s /bin/false -r -g apache_exporter apache_exporter

cat <<EOF > /etc/systemd/system/apache_exporter.service
[Unit]
Description=Prometheus Apache Exporter
Wants=network.target
After=network.target

[Service]
User=apache_exporter
Group=apache_exporter
Type=simple
ExecStart=/usr/local/bin/apache_exporter
Restart=always

[Install]
WantedBy=multi-user.target
EOF

chmod 755 /etc/systemd/system/apache_exporter.service
systemctl daemon-reload
systemctl enable apache_exporter
systemctl start apache_exporter


