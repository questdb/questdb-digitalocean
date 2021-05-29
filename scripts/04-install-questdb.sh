#!/bin/bash

mkdir /tmp/questdb

# Wait for cloud-init
cloud-init status --wait

# Download and extract QuestDB
curl -s "https://dl.questdb.io/snapshots/questdb-${QUESTDB_VERSION}-no-jre-bin.tar.gz" -o /tmp/questdb.tar.gz
tar xf /tmp/questdb.tar.gz -C /tmp/questdb --strip-components 1
mv /tmp/questdb/questdb.jar /usr/local/bin/

# Enable QuestDB on boot.
# Note: The questdb.service config is copied from "files" directory.
systemctl enable questdb.service
