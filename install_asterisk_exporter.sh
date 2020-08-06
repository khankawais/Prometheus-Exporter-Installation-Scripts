#!/bin/bash

################################################################################
# Author : Awais Khan                                                          #
# Use this script as a root user.                                              #
# This script is used to create a Asterisk exporter service for prometheus     #
# the service will use port 9200 by default                                    #
################################################################################

export DEBIAN_FRONTEND=noninteractive

which wget tar 
if [ $? == 1 ];then
printf "\n  Make sure that you have these dependencies installed :

    tar , wget
"
else

wget https://github.com/khankawais/how-to-install-exporter-monitor-with-prometheus-and-grafana/archive/0.1.tar.gz
tar xvf 0.1.tar.gz
cd "how-to-install-exporter-monitor-with-prometheus-and-grafana-0.1/asterisk_exporter"    
cp asterisk_exporter.py /usr/local/bin/asterisk_exporter.py

cat <<EOF > /etc/systemd/system/asterisk_exporter.service


[Unit]
Description=Asterisk exporter metrics monitor calls
Wants=network-online.target
After=network-online.target

[Service]

Type=simple

User=root
Group=root

ExecStart=/usr/local/bin/asterisk_exporter.py

[Install]
WantedBy=multi-user.target

EOF

# apt update -y
# apt install -y python3
# apt install -y python3-pip

pip3 install prometheus
if [ $? == 0 ];then

systemctl daemon-reload
systemctl start asterisk_exporter
systemctl enable asterisk_exporter

fi
fi