FROM alpine:3.12

# Install dependencies
RUN apk update && apk add --no-cache --virtual .build-deps && apk add \
    bash make curl openssh git postgresql-client groff less python2 python3 py-pip\
    && rm /var/cache/apk/* && pip install awscli rotate-backups-s3

VOLUME ["/data/backups"]

ENV BACKUP_DIR /data/backups

ADD . /backup
RUN pip install -e /backup/rotate

ENTRYPOINT ["/backup/entrypoint.sh"]

CMD crond -f -l 2
