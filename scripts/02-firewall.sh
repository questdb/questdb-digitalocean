#!/bin/bash

# Enable ssh connections
ufw allow ssh

# Allow ports used by QuestDB
# Note: port 9009 is intentionally not limited to TCP/UDP
ufw allow 8812/tcp
ufw allow 9000/tcp
ufw allow 9003/tcp
ufw allow 9009

# Enable UFW
ufw --force enable
