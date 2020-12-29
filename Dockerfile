FROM alpine

ARG TZ='Europe/Paris'
ENV DEFAULT_TZ ${TZ}

RUN apk add --update --no-cache curl bind-tools tzdata  && cp /usr/share/zoneinfo/${DEFAULT_TZ} /etc/localtime  && rm -rf /var/cache/apk/*

COPY dynhost.sh /usr/src/app/dynhost.sh
RUN chmod +x /usr/src/app/dynhost.sh

RUN ln -sf /usr/src/app/dynhost.sh /etc/periodic/15min/dynhost

CMD ["crond", "-f"]
