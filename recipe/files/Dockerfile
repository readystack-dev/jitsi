# GENERATED L-009 hermetic Node build (--network=none, SBOM+SLSA-attestation-producing).
# Pinned base from BASE_IMAGE_DIGESTS.lock; vendored resolved /app tree + debs from Dockerfile.vendor.
# NO install verb offline — the fully-resolved, prod-pruned node_modules is COPYd verbatim.
# source.runtime_node false: Node built the static output in the vendor stage; the runtime serves
# source.app_copies and has no Node (vendored/node/ records the build's Node, it is not installed here).
FROM ubuntu:24.04@sha256:9c7f200c07e3d4a03e7249d2c16bf66a51120fb876aa2242cf31451412543289
ENV DEBIAN_FRONTEND=noninteractive HTTP_PORT=8080
RUN --mount=type=bind,source=vendored/debs,target=/tmp/debs \
    set --; for f in /tmp/debs/*.deb; do [ -e "$f" ] && set -- "$@" "$f"; done; \
    for pass in 1 2 3 4 5; do [ $# -eq 0 ] || dpkg -i --skip-same-version "$@" >/dev/null 2>&1 && break; done; \
    dpkg --configure -a && bad= && for d in "$@"; do p=$(dpkg-deb -f "$d" Package) v=$(dpkg-deb -f "$d" Version); \
      case "$(dpkg-query -W -f='${Version} ${db:Status-Abbrev}' "$p" 2>/dev/null)" in "$v ii"*) ;; *) bad="$bad $p=$v" ;; esac; done && \
    { [ -z "$bad" ] || { echo "vendored debs not installed at their vendored version:$bad" >&2; false; }; } && \
    rm -rf /var/lib/apt/lists/* \
           /var/log/dpkg.log /var/log/alternatives.log /var/log/apt /var/cache/ldconfig/aux-cache /var/cache/fontconfig
ARG SOURCE_DATE_EPOCH=1795543181
RUN groupadd -r jitsi && useradd -r -g jitsi -d /var/lib/jitsi-web -m jitsi && \
    : "${SOURCE_DATE_EPOCH:?SOURCE_DATE_EPOCH must be set for a reproducible build}" && \
    sed -ri "s/^([^:]*:[^:]*):[0-9]*:/\1:$((SOURCE_DATE_EPOCH/86400)):/" /etc/shadow && \
    rm -f /etc/passwd- /etc/shadow- /etc/group- /etc/gshadow-
COPY --chown=jitsi:jitsi vendored/jitsi-src/webroot/ /usr/share/jitsi-meet/
RUN mkdir -p /run/jitsi-web && chown -R jitsi:jitsi /run/jitsi-web
COPY jitsi-web-entrypoint.sh /usr/local/bin/jitsi-web-entrypoint.sh
COPY jitsi-web-nginx.conf.tmpl /etc/jitsi-web/nginx.conf.tmpl
RUN chown jitsi:jitsi /usr/local/bin/jitsi-web-entrypoint.sh; chown jitsi:jitsi /etc/jitsi-web/nginx.conf.tmpl; chmod 0755 /usr/local/bin/jitsi-web-entrypoint.sh; chmod 0644 /etc/jitsi-web/nginx.conf.tmpl
LABEL org.opencontainers.image.title="Jitsi Meet"
LABEL org.opencontainers.image.description="The Jitsi Meet browser frontend built from source, served by non-root nginx; needs prosody, jicofo and jitsi-videobridge to host meetings"
LABEL org.opencontainers.image.source="https://github.com/jitsi/jitsi-meet"
LABEL org.opencontainers.image.revision="f765042bf280cbd7dcd4a9bbdb63b09e9e4d3259"
LABEL org.opencontainers.image.version="stable-11248-CE-ubuntu24.04-r8"
LABEL org.opencontainers.image.licenses="Apache-2.0"
LABEL org.opencontainers.image.vendor="ReadyStack.dev"
LABEL readystack.product="jitsi"
LABEL readystack.edition="CE"
LABEL readystack.build_method="source-rebuild-node"
HEALTHCHECK --interval=5s --timeout=60s --start-period=10s \
  CMD curl -fsS -o /dev/null http://127.0.0.1:8080/ || exit 1
USER jitsi
WORKDIR /var/lib/jitsi-web
EXPOSE 8080
ENTRYPOINT ["/usr/local/bin/jitsi-web-entrypoint.sh"]
