# Docker image to use.
FROM sloopstash/base:v1.1.1

# Install system packages.
RUN yum install -y xz

# Install prometheus
WORKDIR /tmp
RUN set -x \
    && wget https://github.com/prometheus/prometheus/releases/download/v2.53.0/prometheus-2.53.0.linux-amd64.tar.gz --quiet \
    && mkdir -p /usr/local/lib/prometheus \
    && tar xvfz prometheus-2.53.0.linux-amd64.tar.gz -C /usr/local/lib/prometheus --strip-components=1 \
    && rm prometheus-2.53.0.linux-amd64.tar.gz

# Create prometheus directories.
WORKDIR ../
RUN set -x \
  && rm -rf prometheus-2.53.0* \
  && mkdir /opt/prometheus \
  && mkdir /opt/prometheus/data \
  && mkdir /opt/prometheus/log \
  && mkdir /opt/prometheus/conf \
  && mkdir /opt/prometheus/script \
  && mkdir /opt/prometheus/system \
  && touch /opt/prometheus/system/server.pid \
  && touch /opt/prometheus/system/supervisor.ini \
  && ln -s /opt/prometheus/system/supervisor.ini /etc/supervisord.d/prometheus.ini \
  && history -c

# Set default work directory.
WORKDIR /opt/prometheus
