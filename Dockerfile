ARG docker_arch

FROM ${docker_arch}/alpine as build

ARG arch
RUN test -n "${arch}"

RUN apk add --update build-base git && \
        git clone https://github.com/pgul/binkd.git && \
        cd binkd && \
        cp mkfls/unix/* . && \
        ./configure && \
        make && \
        rm -rf /var/cache/apk/*


FROM ${docker_arch}/alpine

RUN mkdir -p /var/run/binkd && mkdir -p /var/log/binkd

# binkd
COPY --from=build /binkd/binkd /binkd/


VOLUME /mail

EXPOSE 24554

WORKDIR /binkd

COPY scripts/ /binkd/
RUN chmod +x /binkd/*.sh

ENTRYPOINT ["/bin/sh", "-c", "crond && crontab /binkd/poller.cron && exec /binkd/binkd /binkd/binkd.conf"] 
