# Docker image to use.
FROM sloopstash/base:v1.1.1

# Install system packages.
RUN yum install -y xz

# Install Prometheus
WORKDIR /tmp
RUN set -x \
  && wget https://github.com/prometheus/prometheus/releases/download/v2.53.0/prometheus-2.53.0.linux-amd64.tar.gz --quiet \
  && tar vxf prometheus-2.53.0.linux-amd64.tar.gz > /dev/null \
  && mkdir -p /usr/local/bin \
  && mv prometheus-2.53.0.linux-amd64/prometheus /usr/local/bin/ \
  && mv prometheus-2.53.0.linux-amd64/promtool /usr/local/bin/ \
  && mv prometheus-2.53.0.linux-amd64/console_libraries /usr/local/share/prometheus/ \
  && mv prometheus-2.53.0.linux-amd64/consoles /usr/local/share/prometheus/ \
  && rm -rf prometheus-2.53.0.linux-amd64* prometheus-2.53.0.linux-amd64.tar.gz

# Create Prometheus directories.
RUN set -x \
  && mkdir -p /opt/prometheus/data \
  && mkdir -p /opt/prometheus/log \
  && mkdir -p /opt/prometheus/conf \
  && cp /prometheus.yml /opt/prometheus/conf/prometheus.yml \
  && chmod 644 /opt/prometheus/conf/prometheus.yml \
  && mkdir -p /opt/prometheus/script \
  && mkdir -p /opt/prometheus/system \
  && touch /opt/prometheus/system/server.pid \
  && touch /opt/prometheus/system/supervisor.ini \
  && ln -s /opt/prometheus/system/supervisor.ini /etc/supervisord.d/prometheus.ini \
  && history -c

# Set default work directory.
WORKDIR /opt/prometheus

# Run Prometheus
ENTRYPOINT ["/usr/local/bin/prometheus"]
CMD ["--config.file=/opt/prometheus/conf/prometheus.yml", "--storage.tsdb.path=/opt/prometheus/data"]
