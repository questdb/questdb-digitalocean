#!/bin/bash

# Create questdb user
useradd -r -d /home/questdb -s /bin/false questdb
chown -R questdb:questdb /home/questdb/
chown -R questdb:questdb /var/log/questdb/

# Install java runtime environment
apt-get update && apt-get install --fix-missing && apt-get install -y default-jre
