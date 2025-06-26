FROM alpine:edge

ENV PASSWORD "emptyPassword"
ENV EXIT_NODES ""

EXPOSE 9050 9051

ADD ./entrypoint.sh /entrypoint.sh
ADD ./torrc /tmp/torrc
ADD ./supervisord.conf /etc/supervisord.conf

RUN apk update && \
    apk upgrade && \
    apk add --update-cache \
      --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing/ \
      --allow-untrusted tor supervisor && \
    rm /var/cache/apk/* && \
    chmod a+w /tmp/torrc && \
    chmod +x /entrypoint.sh

USER tor

CMD ["/entrypoint.sh"]