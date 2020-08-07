FROM debian:buster-slim
ENV DEBIAN_FRONTEND noninteractive
RUN mkdir /usr/share/man/man1/
RUN mkdir -p /opt/scripts
RUN apt-get update \
 && apt-get -y upgrade \
 && apt-get -y install --no-install-recommends \
 apt-transport-https \
 nano \
 procps \
 python-setuptools \
 collectd \
 python2.7 \
 python-pip \
 python-lxml \
 libpython2.7 \
 && rm -rf /var/lib/apt/lists/*
RUN pip install fritzconnection
RUN pip install requests
RUN pip install fritzcollectd
RUN ln -fs /usr/share/zoneinfo/Europe/Berlin /etc/localtime
RUN dpkg-reconfigure -f noninteractive tzdata
COPY collectd.conf /etc/collectd
COPY collectd.conf.d/fritzcollectd.conf /etc/collectd/collectd.conf.d
COPY startup.sh /opt/scripts
RUN chmod 777 /opt/scripts/ \
 && chmod +x /opt/scripts/startup.sh

# Run startup-script
ENTRYPOINT ["/bin/bash", "-c", "/opt/scripts/startup.sh"]

