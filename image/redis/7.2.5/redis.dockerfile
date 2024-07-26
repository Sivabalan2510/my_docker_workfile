#Docker image to use
From sloopstash/base:v1.1.1

#Download and extract Nginx
WORKDIR /tmp
RUN set -x \
    && wget https://download.redis.io/redis-stable.tar.gz --quiet \
    && tar -xzvf redis-stable.tar.gz > /dev/null

#Compile and install Redis
WORKDIR redis-stable
RUN set -x \
  && make distclean \
  && make \
  && make install \
  && cp redis.conf /usr/local/bin

# Create Redis directories.
WORKDIR ../
RUN set -x \
  && mkdir /opt/redis \
  && mkdir /opt/redis/data \
  && mkdir /opt/redis/log \
  && mkdir /opt/redis/conf \
  && mkdir /opt/redis/script \
  && mkdir /opt/redis/system \
  && touch /opt/redis/system/server.pid \
  && touch /opt/redis/system/supervisor.ini \
  && ln -s /opt/redis/system/supervisor.ini /etc/supervisord.d/redis.ini \
  && rm -rf /tmp/redis-stable* \
  && history -c

# Set default work directory.
WORKDIR /opt/redis
