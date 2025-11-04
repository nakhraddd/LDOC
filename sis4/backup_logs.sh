#!/bin/bash
# Backup logs daily
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
mkdir -p ~/backups
cp /var/log/syslog ~/backups/syslog_$TIMESTAMP
