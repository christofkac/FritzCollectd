#!/bin/bash
/etc/init.d/collectd start

# Fallback process for keeping container running when all services are stopped
tail -f /dev/null


