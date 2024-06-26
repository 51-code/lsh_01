#!/bin/bash
for file in config.properties credentials.json hostname.json appname.json; do
  if [ ! -f "/config/${file}" ]; then
    echo "ERROR: Missing '/config/${file}', refusing to continue";
    exit 1;
  fi;
done;

if [ -f /config/log4j2.xml ]; then
    LOG4J_FILE="/config/log4j2.xml";
else
    echo "INFO: Missing '/config/log4j2.xml', using default logger config";
    LOG4J_FILE="/opt/teragrep/lsh_01/etc/log4j2.xml";
fi;

exec /usr/bin/java \
 -Dproperties.file=/config/config.properties \
 -Dcredentials.file=/config/credentials.json \
 -Dlookups.hostname.file=/config/hostname.json \
 -Dlookups.appname.file=/config/appname.json \
 -Dlog4j2.configurationFile=file:"${LOG4J_FILE}" \
 -jar /opt/teragrep/lsh_01/share/lsh_01.jar
