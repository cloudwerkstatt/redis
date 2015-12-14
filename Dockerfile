FROM docker.io/centos:latest
MAINTAINER Udo Urbantschitsch udo@urbantschitsch.com

LABEL io.openshift.tags redis,redis3,redis305
LABEL io.k8s.description Redis Cache Image
LABEL io.openshift.expose-services 6379/tcp

ENV REDIS_VERSION 3.0.5

RUN \
yum update -y && \
yum install -y gcc gcc-c++ make tcl && \
mkdir /data && \
curl -O http://download.redis.io/releases/redis-$REDIS_VERSION.tar.gz && \
tar xvzf redis-$REDIS_VERSION.tar.gz && \
cd redis-$REDIS_VERSION && \
make && \
# make test && \
make install && \
cd .. && rm -rf redis* && \
chmod -R 777 /data

ADD container-files /

EXPOSE 6379

RUN useradd redis

USER redis

CMD ["redis-server", "/etc/redis.conf"]
