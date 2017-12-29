FROM debian

ENV HOME /tmp

RUN set -ex \
 && apt-get update \
 && apt-get install -y gnupg2

ADD https://dl-ssl.google.com/linux/linux_signing_key.pub /tmp/linux_signing_key.pub
ADD google.list /etc/apt/sources.list.d/google.list

RUN set -ex \
 && apt-key add /tmp/linux_signing_key.pub \
 && apt-get update \
 && apt-get install -y imagemagick google-chrome-stable

VOLUME ["/data"]
ENTRYPOINT ["/usr/local/bin/run.sh"]

ADD run.sh /usr/local/bin/run.sh

WORKDIR /data
