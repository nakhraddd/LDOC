#!/bin/bash
set -e
set -x

echo "--- SIS 3: INSTALLING PACKAGES AND FIREWALL ---"

echo "Updating apt cache..."
sudo apt-get update

echo "Installing system packages..."
sudo apt-get install -y build-essential python3-pip python3-dev \
    mysql-server libmysqlclient-dev ufw wget

echo "Installing Python packages..."
sudo pip3 install django gunicorn mysqlclient prometheus-client

echo "Downloading and installing Prometheus..."
cd /tmp
wget https://github.com/prometheus/prometheus/releases/download/v2.53.1/prometheus-2.53.1.linux-amd64.tar.gz
tar -xvf prometheus-2.53.1.linux-amd64.tar.gz
sudo mv prometheus-2.53.1.linux-amd64/prometheus /usr/local/bin/
sudo mv prometheus-2.53.1.linux-amd64/promtool /usr/local/bin/
sudo mv prometheus-2.53.1.linux-amd64/prometheus.yml /etc/prometheus/
sudo chown prometheus:monitoring /usr/local/bin/prometheus
sudo chown prometheus:monitoring /usr/local/bin/promtool

echo "Downloading and installing Grafana..."
cd /tmp
wget https://dl.grafana.com/oss/release/grafana-11.1.0.linux-amd64.tar.gz
tar -xvf grafana-11.1.0.linux-amd64.tar.gz
sudo mv grafana-11.1.0/bin/grafana-server /usr/local/bin/
sudo mv grafana-11.1.0/bin/grafana-cli /usr/local/bin/
sudo chown -R grafana:monitoring /usr/local/bin/grafana-server
sudo chown -R grafana:monitoring /usr/local/bin/grafana-cli

echo "Configuring firewall (UFW)..."
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow ssh
sudo ufw allow http
sudo ufw allow https
sudo ufw allow 3000/tcp
sudo ufw allow 9090/tcp
sudo ufw allow 8000/tcp
sudo ufw --force enable

echo "Running smoke tests..."
python3 -m django --version
gunicorn --version
mysql --version
prometheus --version
grafana-server -v

echo "Checking MySQL service..."
sudo systemctl status mysql

echo "--- SIS 3 COMPLETE ---"