#!/bin/bash

service rsyslog restart
chmod 666 /var/log/syslog
service nginx start
service redis-server start
service elasticsearch start
/opt/logstash/bin/logstash agent -f /etc/logstash/conf.d/syslog_shipper.conf &
/opt/logstash/bin/logstash agent -f /etc/logstash/conf.d/syslog_indexer.conf &
/kibana-4.0.0-beta3/bin/kibana &
