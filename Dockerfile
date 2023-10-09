FROM alpine:3.18.4

# Set labels manually, each build service differs in used or predefined labels.
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

# Use a individual user and group ip for files and process
ENV TINYPROXY_UID 5123
ENV TINYPROXY_GID 5123

ENV UPSTREAM_PROXY ""
ENV UPSTREAM_PROXY_FILE ""
ENV PORT "8888"
ENV TIMEOUT "600"
ENV LOGLEVEL "Info"
ENV MAXCLIENTS "600"
ENV FILTER_FILE "/app/filter"

ENV TZ "Europe/Berlin"

# get existing packages
# curl for healthchecks and debugging
RUN apk add --no-cache \
      tinyproxy curl tzdata

COPY entrypoint.sh /app/entrypoint.sh

RUN touch /app/proxy.conf && \
  chmod +x /app/entrypoint.sh && \
  chown -R ${TINYPROXY_UID}:${TINYPROXY_GID} /app /etc/tinyproxy /var/log/tinyproxy

USER ${TINYPROXY_UID}:${TINYPROXY_GID}
WORKDIR /app

EXPOSE 8888

ENTRYPOINT ["/app/entrypoint.sh"]
CMD ["-c", "/app/proxy.conf", "-d"]
