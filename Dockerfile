FROM __BASE_IMAGE_ARCH__/alpine:3.9

ARG ARIA_NG_VERSION=1.1.4

RUN apk update && \
	apk add --no-cache --update bash && \
	mkdir -p /conf && \
	mkdir -p /conf-copy && \
	mkdir -p /data && \
	mkdir -p /aria2-ng && \
	apk add --no-cache --update aria2 && \
	apk add --no-cache wget && \
    wget https://github.com/mayswind/AriaNg/releases/download/${ARIA_NG_VERSION}/AriaNg-${ARIA_NG_VERSION}.zip -O /aria2-ng/archive.zip && \
    cd /aria2-ng && \
    unzip archive.zip && \
    rm archive.zip && \
    apk del wget && \
    apk add --update lighttpd && \
    rm -rf /var/cache/apk/*

ADD files/start.sh /conf-copy/start.sh
ADD files/aria2.conf /conf-copy/aria2.conf
ADD files/lighttpd.conf /etc/lighttpd/lighttpd.conf

RUN chmod +x /conf-copy/start.sh

WORKDIR /
VOLUME ["/data"]
VOLUME ["/conf"]
EXPOSE 6800
EXPOSE 80

#HEALTHCHECK --interval=1m --timeout=1s \
#  CMD curl -f http://localhost/ || exit 1

CMD ["/conf-copy/start.sh"]
