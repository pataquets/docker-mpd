FROM pataquets/ubuntu:xenial

RUN \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive \
    apt-get install -y mpd \
  && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/ \
  && \
  mkdir -vp \
    /var/lib/mpd \
    /run/mpd \
  && \
  chown -v mpd:audio \
    /var/lib/mpd \
    /run/mpd \
  && \
  sed -i -e 's/bind_to_address\t\t"localhost"/bind_to_address\t\t"0.0.0.0"/' /etc/mpd.conf
