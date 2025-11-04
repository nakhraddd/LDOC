#!/bin/bash
# Schedule both tasks with cron

CRON_FILE="/etc/cron.d/devops_tasks"

sudo tee $CRON_FILE > /dev/null <<EOF
# Backup logs every day at 02:00
0 2 * * * root /bin/bash /home/$USER/backup_logs.sh

# Health check every 5 minutes
*/5 * * * * root /bin/bash /home/$USER/health_check.sh
EOF

sudo chmod 644 $CRON_FILE
sudo systemctl restart cron
