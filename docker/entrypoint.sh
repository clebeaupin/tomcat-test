#!/bin/bash

sed -i "s/LOG4J_SOCKET_PORT/$LOG4J_SOCKET_PORT/g" $CATALINA_HOME/conf/log4j.properties
sed -i "s/LOG4J_SOCKET_HOST/$LOG4J_SOCKET_HOST/g" $CATALINA_HOME/conf/log4j.properties

exec "$@"
