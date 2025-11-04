#!/bin/bash
# Check if container is running and restart if not
CONTAINER_NAME="flask-docker"
if ! docker ps | grep -q "$CONTAINER_NAME"; then
    echo "$(date): Container not running. Restarting..." >> ~/container_health.log
    systemctl restart flask-docker.service
else
    echo "$(date): Container is healthy." >> ~/container_health.log
fi
