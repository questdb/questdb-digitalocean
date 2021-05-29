#!/bin/bash
#
# Remove log files generated during instance creation and
# configuration.

rm -rf /var/log/kern.log
rm -rf /var/log/ufw.log
rm -rf /var/log/questdb/questdb.log
