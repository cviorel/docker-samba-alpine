FROM alpine:latest
LABEL MAINTAINER="Viorel Ciucu <viorel.ciucu@gmail.com>" \
      Description="Lightweight Samba docker container, based on Alpine Linux."

ENV PACKAGE_LIST="samba samba-common-tools supervisor"

RUN apk update && \
    apk add --no-cache ${PACKAGE_LIST} && \
    rm -rf /tmp/* && \
    rm -rf /var/cache/apk/*

# create a dir for the config and the share
RUN mkdir /config /shared

# copy config files from project folder to get a default config going for samba and supervisord
COPY *.conf /config/

VOLUME /config /shared

ADD ./entrypoint.sh /entrypoint.sh
RUN chmod u+x /entrypoint.sh

EXPOSE 135/tcp 137/udp 138/udp 139/tcp 445/tcp

HEALTHCHECK --interval=60s --timeout=15s \
            CMD smbclient -L \\localhost -U % -m SMB3

ENTRYPOINT ["/entrypoint.sh"]
