#!/bin/bash

service rsyslog restart
chmod 666 /var/log/syslog
service nginx start
service redis-server start
service elasticsearch start
/opt/logstash/bin/logstash agent -f /etc/logstash/conf.d/syslog_shipper.conf &
sleep 3
/opt/logstash/bin/logstash agent -f /etc/logstash/conf.d/syslog_indexer.conf &
sleep 3
echo "giving elasticsearch & redis some time to start ..."
sleep 3
/kibana-4.0.0-linux-x64/bin/kibana &
