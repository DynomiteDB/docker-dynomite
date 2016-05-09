#
# DynomiteDB: Dynomite server runtime container
#
FROM dynomitedb/base

MAINTAINER Akbar S. Ahmed <akbar@dynomitedb.com>

#
# Environment variables
#
ENV DYNOMITE_USER dynomite
ENV DYNOMITE_GROUP dynomite

#
# Install dependencies
#
RUN groupadd -r $DYNOMITE_GROUP && \
    useradd -r -g $DYNOMITE_GROUP $DYNOMITE_USER && \
    apt-get update && \
    apt-get install -y \
    software-properties-common \
	apt-transport-https \
    ca-certificates && \
	apt-key adv --keyserver keyserver.ubuntu.com --recv-keys FB3291D9 && \
    add-apt-repository "deb https://apt.dynomitedb.com/ trusty main" && \
    apt-get update && \
    apt-get install -y dynomitedb-dynomite && \
    rm -rf /var/lib/apt/lists/*

#
# Mountable directories
#
#VOLUME ["/dir-on-host:/dir-in-container"]

#
# Working directory (similar to `cd $WORKDIR` for all following commands)
#
WORKDIR /

#
# Default command
#
COPY docker-entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
#CMD dynomite -c /etc/dynomitedb/dynomite.yaml -p /var/run/dynomitedb/dynomite.pid
CMD ["dynomite", "-c", "/etc/dynomitedb/dynomite.yaml", "-p", "/var/run/dynomitedb/dynomite.pid"]

#
# Expose ports
#
EXPOSE 8101
EXPOSE 8102
