#!/bin/bash
# Create and enable systemd unit for Docker container

SERVICE_NAME="flask-docker.service"
IMAGE_NAME="darkhant/services-app:v1"

sudo tee /etc/systemd/system/$SERVICE_NAME > /dev/null <<EOF
[Unit]
Description=Flask Docker Container
After=docker.service
Requires=docker.service

[Service]
Restart=always
ExecStart=/usr/bin/docker run --rm -p 8080:8080 $IMAGE_NAME
ExecStop=/usr/bin/docker stop \$(/usr/bin/docker ps -q --filter ancestor=$IMAGE_NAME)
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

sudo systemctl daemon-reload
sudo systemctl enable $SERVICE_NAME
sudo systemctl start $SERVICE_NAME
sudo systemctl status $SERVICE_NAME
