FROM alpine:3.18.2

#LABEL build_version=""
LABEL maintainer="OCram85"
ARG VERSION
LABEL build_version="${VERSION}"
LABEL org.opencontainers.image.authors="OCram85"
LABEL org.opencontainers.image.vendor="OCram85"

LABEL org.opencontainers.image.title="swarmproxy"
LABEL org.opencontainers.image.description="tinyproxy docker image"
LABEL org.opencontainers.image.licenses="AGPL-3.0"
ARG TAG
LABEL org.opencontainers.image.version="${TAG}"

LABEL org.opencontainers.image.url="https://gitea.ocram85.com/OCram85/swarmproxy"
LABEL org.opencontainers.image.source="https://gitea.ocram85.com/OCram85/swarmproxy.git"
LABEL org.opencontainers.image.documentation="https://gitea.ocram85.com/OCram85/swarmproxy"

# Use a custom UID/GID instead of the default system UID which has a greater possibility
# for collisions with the host and other containers.
ENV TINYPROXY_UID 5123
ENV TINYPROXY_GID 5123

ENV UPSTREAM_PROXY ""
ENV PORT "8888"
ENV TIMEOUT "600"
ENV LOGLEVEL "Info"
ENV MAXCLIENTS "600"
ENV FILTER_FILE "/etc/tinyproxy/filter"

# Curl is for healthchecks.
RUN apk add --no-cache \
      tinyproxy curl

RUN mv /etc/tinyproxy/tinyproxy.conf /etc/tinyproxy/tinyproxy.default.conf

RUN <<EOF cat >> /etc/tinyproxy/tinyproxy.conf
User $TINYPROXY_UID
Group $TINYPROXY_GID
Port $PORT
Timeout $TIMEOUT
DefaultErrorFile "/usr/share/tinyproxy/default.html"

StatHost "tinyproxy.stats"
StatFile "/usr/share/tinyproxy/stats.html"

LogLevel $LOGLEVEL
MaxClients $MAXCLIENTS
ViaProxyName "tinyproxy"

#upstream http $UPSTREAM_PROXY "."

Filter "$FILTER_FILE"
FilterURLs Off
FilterCaseSensitive Off
FilterDefaultDeny Yes

Allow 127.0.0.1/8
Allow 10.0.0.0/8
EOF

RUN chown -R ${TINYPROXY_UID}:${TINYPROXY_GID} /etc/tinyproxy /var/log/tinyproxy
USER ${TINYPROXY_UID}:${TINYPROXY_GID}

EXPOSE 8888

ENTRYPOINT ["/usr/bin/tinyproxy", "-d"]
