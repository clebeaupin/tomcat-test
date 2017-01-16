FROM tomcat:8.0

ENV LOG4J_VER 1.2.17
ENV LOG4J_JAR log4j-${LOG4J_VER}.jar
ENV LOG4J_URL "http://archive.apache.org/dist/logging/log4j/${LOG4J_VER}/${LOG4J_JAR}"

ENV JULI_URL "https://www.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/extras/tomcat-juli.jar"
ENV JULI_ADAPTER_URL "https://www.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR}/v${TOMCAT_VERSION}/bin/extras/tomcat-juli-adapters.jar"
ENV CATALINA_OPTS "$CATALINA_OPTS -Dlog4j.debug -Dlog4j.configuration=file://${CATALINA_HOME}/conf/log4j.properties"
ENV LOG4J_SOCKET_PORT 12000
ENV LOG4J_SOCKET_HOST localhost

RUN curl $LOG4J_URL > $CATALINA_HOME/lib/$LOG4J_JAR && \
    curl $JULI_URL > $CATALINA_HOME/bin/tomcat-juli.jar && \
    curl $JULI_ADAPTER_URL > $CATALINA_HOME/lib/tomcat-juli-adapters.jar

COPY docker/log4j.properties $CATALINA_HOME/conf
COPY docker/entrypoint.sh /entrypoint.sh

RUN chmod a+x /entrypoint.sh

CMD ["catalina.sh", "run"]
ENTRYPOINT ["/entrypoint.sh"]
