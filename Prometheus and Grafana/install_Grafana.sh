#!/bin/bash

################################################################################
# Author : Awais Khan                                                          #
# Use this script as a root user.                                              #
# This script is used to install Grafana on Ubuntu                             #
# Prometheus Runs on 3000 port                                                 #
################################################################################

apt update -y
apt install -y gnupg2 software-properties-common
wget -q -O - https://packages.grafana.com/gpg.key | apt-key add -
add-apt-repository "deb https://packages.grafana.com/oss/deb stable main"
apt update
apt install grafana
systemctl start grafana-server
systemctl enable grafana-server
