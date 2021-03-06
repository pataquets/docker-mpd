FROM pataquets/ubuntu:focal

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

ADD ./audio_output.httpd.conf /etc/mpd.conf.d/
RUN \
  cat /etc/mpd.conf.d/audio_output.httpd.conf | \
    tee -a /etc/mpd.conf && \
  nl /etc/mpd.conf

ENTRYPOINT [ "mpd", "--no-daemon" ]
