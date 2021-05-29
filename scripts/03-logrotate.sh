#!/bin/bash

echo "*/5 * * * * /etc/cron.daily/logrotate" | sudo crontab -
