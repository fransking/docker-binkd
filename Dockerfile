ARG docker_arch

FROM ${docker_arch}/alpine:3.12 as build

ARG arch
RUN test -n "${arch}"

RUN apk upgrade --update-cache --available && \
        apk add --update build-base git && \
        git clone https://github.com/pgul/binkd.git && \
        cd binkd && \
        cp mkfls/unix/* . && \
        ./configure && \
        make && \
        rm -rf /var/cache/apk/*


FROM ${docker_arch}/alpine:3.12

RUN apk upgrade --update-cache --available && \
        apk add openssl && \
        rm -rf /var/cache/apk/*

RUN mkdir -p /var/run/binkd && mkdir -p /var/log/binkd

# binkd
COPY --from=build /binkd/binkd /binkd/


VOLUME /mail
VOLUME /var/log/binkd

EXPOSE 24554

WORKDIR /binkd

COPY scripts/ /binkd/
RUN chmod +x /binkd/*.sh

ENTRYPOINT ["/bin/sh", "-c", "crond && crontab /binkd/poller.cron && exec /binkd/binkd /binkd/binkd.conf"] 
