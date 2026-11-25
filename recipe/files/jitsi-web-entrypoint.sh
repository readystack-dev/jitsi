#!/bin/bash
# ReadyStack jitsi-meet web frontend: render config.js + nginx.conf from the environment, then run nginx in the
# foreground as the non-root jitsi user. Environment names match docker-jitsi-meet's `web` service, so this
# container can take that service's place next to its prosody, jicofo and jvb containers.
set -euo pipefail
RUN_DIR=/run/jitsi-web
WEBROOT=/usr/share/jitsi-meet
mkdir -p "$RUN_DIR/tmp"

XMPP_DOMAIN="${XMPP_DOMAIN:-meet.jitsi}"
XMPP_MUC_DOMAIN="${XMPP_MUC_DOMAIN:-muc.meet.jitsi}"
XMPP_GUEST_DOMAIN="${XMPP_GUEST_DOMAIN:-guest.meet.jitsi}"
XMPP_BOSH_URL_BASE="${XMPP_BOSH_URL_BASE:-http://xmpp.meet.jitsi:5280}"
ENABLE_XMPP_WEBSOCKET="${ENABLE_XMPP_WEBSOCKET:-1}"
ENABLE_AUTH="${ENABLE_AUTH:-0}"
ENABLE_GUESTS="${ENABLE_GUESTS:-0}"
HTTP_PORT="${HTTP_PORT:-8080}"

is_true() { case "${1,,}" in 1|true|yes|on) return 0;; *) return 1;; esac; }
for v in XMPP_DOMAIN XMPP_MUC_DOMAIN XMPP_GUEST_DOMAIN; do
  case "${!v}" in ''|*[!A-Za-z0-9.-]*) echo "jitsi-web: $v must be a DNS name, got '${!v}'" >&2; exit 1;; esac
done
if ! [[ "$XMPP_BOSH_URL_BASE" =~ ^https?://[A-Za-z0-9.-]+(:[0-9]+)?$ ]]; then
  echo "jitsi-web: XMPP_BOSH_URL_BASE must look like http://host:port (no path), got '$XMPP_BOSH_URL_BASE'" >&2; exit 1
fi
if ! [[ "$HTTP_PORT" =~ ^[0-9]+$ ]] || [ "$HTTP_PORT" -lt 1024 ]; then
  echo "jitsi-web: HTTP_PORT must be a number >= 1024 (the server runs as a non-root user), got '$HTTP_PORT'" >&2; exit 1
fi

# DNS server nginx uses to find prosody at request time, so the web container starts even while prosody is down.
RESOLVER="${NGINX_RESOLVER:-$(awk '/^nameserver/ {print $2; exit}' /etc/resolv.conf 2>/dev/null || true)}"
RESOLVER="${RESOLVER:-127.0.0.11}"
case "$RESOLVER" in *:*) case "$RESOLVER" in \[*) ;; *) RESOLVER="[$RESOLVER]";; esac;; esac

# config.js: upstream's default config.js with the host substitution the jitsi-meet-web-config package makes,
# then the same overrides docker-jitsi-meet's system-config.js writes.
sed "s/jitsi-meet\.example\.com/${XMPP_DOMAIN}/g" "$WEBROOT/config.js" > "$RUN_DIR/config.js"
{
  echo ""
  echo "// ReadyStack: generated from the container environment at start"
  echo "config.hosts.domain = '${XMPP_DOMAIN}';"
  echo "config.hosts.muc = '${XMPP_MUC_DOMAIN}';"
  if is_true "$ENABLE_AUTH"; then
    echo "config.hosts.authdomain = '${XMPP_DOMAIN}';"
    if is_true "$ENABLE_GUESTS"; then echo "config.hosts.anonymousdomain = '${XMPP_GUEST_DOMAIN}';"; fi
  fi
  echo "config.bosh = '/' + subdir + 'http-bind';"
  if is_true "$ENABLE_XMPP_WEBSOCKET"; then
    echo "config.websocket = (location.protocol === 'https:' ? 'wss://' : 'ws://') + location.host + '/' + subdir + 'xmpp-websocket';"
  else
    echo "delete config.websocket;"
  fi
} >> "$RUN_DIR/config.js"

sed -e "s|@HTTP_PORT@|${HTTP_PORT}|g" -e "s|@XMPP_DOMAIN@|${XMPP_DOMAIN}|g" \
    -e "s|@XMPP_BOSH_URL_BASE@|${XMPP_BOSH_URL_BASE}|g" -e "s|@RESOLVER@|${RESOLVER}|g" \
    /etc/jitsi-web/nginx.conf.tmpl > "$RUN_DIR/nginx.conf"
nginx -e stderr -t -q -c "$RUN_DIR/nginx.conf"
exec nginx -e stderr -c "$RUN_DIR/nginx.conf" -g 'daemon off;'
