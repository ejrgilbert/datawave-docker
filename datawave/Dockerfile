FROM accumulo

# Can override these on the command line when running a new container if necessary
ENV DW_DATAWAVE_ACCUMULO_AUTHS="PUBLIC,PRIVATE,FOO,BAR,DEF,A,B,C,D,E,F,G,H,I,DW_USER,DW_SERV,DW_ADMIN,JBOSS_ADMIN"
ENV LIVE_INGEST_DATA_TYPES="wikipedia,mycsv,myjson"

ENV HADOOP_USER_NAME datawave
ENV DATAWAVE_HOME /opt/datawave

ENV HDFS_BASE "hdfs://namenode:8020"
ENV DW_DATAWAVE_INGEST_HDFS_BASEDIR "${HDFS_BASE}/data"
ENV DW_INSTALL_DIR /opt/datawave-ingest

# Add root and datawave to the hadoop superusergroup...
RUN groupadd hadoop && \
    useradd datawave && \
    useradd accumulo && \
    usermod -a -G hadoop root && \
    usermod -a -G hadoop datawave \
    usermod -a G hadoop accumulo

# Fix permissions of various files
RUN mkdir ${DW_INSTALL_DIR} && \
    mkdir -p /srv/logs/ingest && \
    chmod 777 /srv/logs/ingest && \
    mkdir -p /srv/vfs-cache && \
    chmod 777 /srv/vfs-cache && \
    mkdir -p /srv/run/datawave && \
    chmod 777 /srv/run/datawave && \
    mkdir -p /srv/data && \
    chmod 775 /srv/data && \
    chmod 750 ${ACCUMULO_HOME} && \
    chmod 750 ${DW_INSTALL_DIR} && \
    mkdir -p /srv/data/datawave/flags && \
    chown -R datawave:hadoop /srv/data/datawave && \
    chmod -R 755 /srv/data/datawave && \
    mkdir -p /srv/data/ingest && \
    chown datawave:hadoop /srv/data/ingest && \
    chmod 775 /srv/data/ingest


ENV PATH "$PATH:$ACCUMULO_HOME/bin:$HADOOP_HOME/bin:$ZOOKEEPER_HOME/bin"
RUN echo "export DATAWAVE_HOME=/opt/datawave" >> ~datawave/.bashrc && \
    echo "export ACCUMULO_HOME=/opt/accumulo/current" >> ~datawave/.bashrc && \
    echo "export HADOOP_HOME=/usr/lib/hadoop" >> ~datawave/.bashrc && \
    echo "export ZOOKEEPER_HOME=/usr/lib/zookeeper" >> ~datawave/.bashrc && \
    echo "export ACCUMULO_CONF_DIR=${ACCUMULO_HOME}/conf" >> ~datawave/.bashrc && \
    echo "export ACCUMULO_LOG_DIR=/srv/logs/accumulo" >> ~datawave/.bashrc && \
    echo "export JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk" >> ~datawave/.bashrc && \
    echo "export PATH=$PATH" >> ~datawave/.bashrc

ADD entrypoint.sh /entrypoint.sh
ADD init.sh /init.sh
RUN chmod 777 /entrypoint.sh && \
    chmod 777 /init.sh

# initialize container and start ingest
ENTRYPOINT ["/entrypoint.sh"]
CMD ["/init.sh"]
