#!/usr/bin/env sh

set -e

CONFIG="/app/proxy.conf"

function writeConfig() {
    cat << EOF >> "$CONFIG"
User $TINYPROXY_UID
Group $TINYPROXY_GID
Port $PORT
Timeout $TIMEOUT
DefaultErrorFile "/usr/share/tinyproxy/default.html"

StatHost "tinyproxy.stats"
StatFile "/usr/share/tinyproxy/stats.html"

LogLevel $LOGLEVEL
MaxClients $MAXCLIENTS
ViaProxyName "Swarmproxy"

Allow 127.0.0.1/8
Allow 10.0.0.0/8

EOF
}

function addUpstreamConfig() {
  [ -z "$UPSTREAM_PROXY_FILE" ] || export UPSTREAM_PROXY=$(cat $UPSTREAM_PROXY_FILE)
  [ -z "$UPSTREAM_PROXY" ] || echo "Upstream http $UPSTREAM_PROXY " >> "$CONFIG"
}

function addFilterConfig() {
  if [ -f "$FILTER_FILE" ]; then
    cat << FBLOCK >> "$CONFIG"
Filter "$FILTER_FILE"
FilterURLs Off
FilterCaseSensitive Off
FilterDefaultDeny Yes
FBLOCK
  else
    echo "🦁 FILTER_FILE not found or set."
  fi
}

function showConfig() {
  echo "🦁 Final Swarmproxy config 🦁"
  cat "$CONFIG"
}

function execTinyproxy() {
  echo "🦁 Starting Tinyproxy..."
  echo "args count: $#"
  echo "args value: $@"
  exec "/usr/bin/tinyproxy" "$@"
}

function main() {
  writeConfig
  addUpstreamConfig
  addFilterConfig
  showConfig
  execTinyproxy $@
}

main $@
echo "entrypoint end. 🚀"
