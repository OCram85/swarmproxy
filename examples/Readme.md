---
gitea: none
include_toc: true
---

# 📘 Examples

This folder contains some examples you can use to start building your Swarmproxy stack.

## Basic example `(1-minimal.yml)`

### Source

> 🗄️ File: [1-minimal.yml](1-minimal.yml)

### Description

This is the mos basic example. It contains the Swarmproxy service and curl als helper. Just deploy the stack and
inspect the logs form the containers.

### Usage

```bash
docker stack deploy -c 1-minimal.yml swarmproxy-mini
```

### Container Logs

- Swarmproxy:

```
🦁 FILTER_FILE not found or set.
🦁 Final Swarmproxy config 🦁

3
Group 5123

8
Timeout 600
DefaultErrorFile "/usr/share/tinyproxy/default.html"
StatHost "tinyproxy.stats"
StatFile "/usr/share/tinyproxy/stats.html"
LogLevel Info
MaxClients 600
ViaProxyName "Swarmproxy"
Allow 127.0.0.1/8
Allow 10.0.0.0/8
🦁 Starting Tinyproxy...
args count: 3
args value: -c /app/proxy.conf -d
NOTICE    Jul 13 11:10:23.360 [1]: Initializing tinyproxy ...
NOTICE    Jul 13 11:10:23.360 [1]: Reloading config file
INFO      Jul 13 11:10:23.360 [1]: Stathost set to "tinyproxy.stats"
INFO      Jul 13 11:10:23.360 [1]: Setting "Via" header to 'Swarmproxy'
NOTICE    Jul 13 11:10:23.360 [1]: Reloading config file finished
INFO      Jul 13 11:10:23.360 [1]: listen_sock called with addr = '(NULL)'
INFO      Jul 13 11:10:23.360 [1]: trying to listen on host[0.0.0.0], family[2], socktype[1], proto[6]
INFO      Jul 13 11:10:23.360 [1]: listening on fd [3]
INFO      Jul 13 11:10:23.360 [1]: trying to listen on host[::], family[10], socktype[1], proto[6]
INFO      Jul 13 11:10:23.360 [1]: listening on fd [4]
INFO      Jul 13 11:10:23.360 [1]: Not running as root, so not changing UID/GID.
INFO      Jul 13 11:10:23.360 [1]: Setting the various signals.
INFO      Jul 13 11:10:23.360 [1]: Starting main loop. Accepting connections.
CONNECT   Jul 13 11:10:29.845 [1]: Connect (file descriptor 5): 10.0.35.4
CONNECT   Jul 13 11:10:29.845 [1]: Request (file descriptor 5): CONNECT google.com:443 HTTP/1.1
INFO      Jul 13 11:10:29.845 [1]: No upstream proxy for google.com
INFO      Jul 13 11:10:29.845 [1]: opensock: opening connection to google.com:443
INFO      Jul 13 11:10:29.955 [1]: opensock: getaddrinfo returned for google.com:443
CONNECT   Jul 13 11:10:29.959 [1]: Established connection to host "google.com" using file descriptor 6.
INFO      Jul 13 11:10:29.959 [1]: Not sending client headers to remote machine
INFO      Jul 13 11:10:30.033 [1]: Closed connection between local client (fd:5) and remote client (fd:6)
```

- Curl:

```
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
HTTP/1.0 200 Connection established

  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
  0   220    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
Proxy-agent: tinyproxy/1.11.1

HTTP/2 301
location: https:xt/html; charset=UTF-8
content-security//www.google.com/
content-type: te-policy-report-only: object-src 'none';base-uri 'self';script-src 'nonce-gEktpIC_xSqk9njjM0KANA' 'strict-dynamic' 'report-sample' 'unsafe-eval' 'unsafe-inline' https: http:;report-uri https://csp.withgoogle.com/csp/gws/other-hp
date: Thu, 13 Jul 2023 11:10:29 GMT
expires: Thu, 13 Jul 2023 11:10:29 GMT
cache-control: private, max-age=2592000

server: gws
content-length: 220
x-xss-protection: 0
x-frame-options: SAMEORIGIN
set-cookie: CONSENT=PENDING+663; expires=Sat, 12-Jul-2025 11:10:29 GMT; path=/; domain=.google.com; Secure
p3p: CP="This is not a P3P policy! See g.co/p3phelp for more info."
alt-svc: h3=":443"; ma=2592000,h3-29=":443"; ma=2592000
```

## Upstream proxy example `(2-upstream.yml)`

### Source

> 🗄️ File: [2-upstream.yml](2-upstream.yml)

### Description

The upstream example contains another Swarmproxy instance as fake upstream proxy. The client connects to it's
configured Swarmproxy instance which forwards the query to the upstream.

### Usage

```bash
docker stack deploy -c 2-upstream.yml swarmproxy-upstream
```

### Container Logs

- Upstream

```
🦁 FILTER_FILE not found or set.
🦁 Final Swarmproxy config 🦁

3
Group 5123
8
Timeout 600
DefaultErrorFile "/usr/share/tinyproxy/default.html"
StatHost "tinyproxy.stats"
StatFile "/usr/share/tinyproxy/stats.html"
LogLevel Info
MaxClients 600
ViaProxyName "Swarmproxy"
Allow 127.0.0.1/8
Allow 10.0.0.0/8
🦁 Starting Tinyproxy...
args count: 3
args value: -c /app/proxy.conf -d
NOTICE    Jul 13 11:18:50.279 [1]: Initializing tinyproxy ...
NOTICE    Jul 13 11:18:50.279 [1]: Reloading config file
INFO      Jul 13 11:18:50.279 [1]: Stathost set to "tinyproxy.stats"
INFO      Jul 13 11:18:50.279 [1]: Setting "Via" header to 'Swarmproxy'
NOTICE    Jul 13 11:18:50.279 [1]: Reloading config file finished
INFO      Jul 13 11:18:50.279 [1]: listen_sock called with addr = '(NULL)'
INFO      Jul 13 11:18:50.279 [1]: trying to listen on host[0.0.0.0], family[2], socktype[1], proto[6]
INFO      Jul 13 11:18:50.279 [1]: listening on fd [3]
INFO      Jul 13 11:18:50.279 [1]: trying to listen on host[::], family[10], socktype[1], proto[6]
INFO      Jul 13 11:18:50.279 [1]: listening on fd [4]
INFO      Jul 13 11:18:50.279 [1]: Not running as root, so not changing UID/GID.
INFO      Jul 13 11:18:50.279 [1]: Setting the various signals.
INFO      Jul 13 11:18:50.279 [1]: Starting main loop. Accepting connections.
```

- Swarmproxy

```
🦁 FILTER_FILE not found or set.
🦁 Final Swarmproxy config 🦁
3
Group 5123
8
Timeout 600
DefaultErrorFile "/usr/share/tinyproxy/default.html"
StatHost "tinyproxy.stats"
StatFile "/usr/share/tinyproxy/stats.html"
LogLevel Info
MaxClients 600
ViaProxyName "Swarmproxy"
Allow 127.0.0.1/8
Allow 10.0.0.0/8
Upstream http upstream:8888
🦁 Starting Tinyproxy...
args count: 3
args value: -c /app/proxy.conf -d
NOTICE    Jul 13 11:22:46.583 [1]: Initializing tinyproxy ...
NOTICE    Jul 13 11:22:46.583 [1]: Reloading config file
INFO      Jul 13 11:22:46.583 [1]: Stathost set to "tinyproxy.stats"
INFO      Jul 13 11:22:46.583 [1]: Setting "Via" header to 'Swarmproxy'
INFO      Jul 13 11:22:46.583 [1]: Added upstream http upstream:8888 for [default]
NOTICE    Jul 13 11:22:46.583 [1]: Reloading config file finished
INFO      Jul 13 11:22:46.583 [1]: listen_sock called with addr = '(NULL)'
INFO      Jul 13 11:22:46.583 [1]: trying to listen on host[0.0.0.0], family[2], socktype[1], proto[6]
INFO      Jul 13 11:22:46.583 [1]: listening on fd [3]
INFO      Jul 13 11:22:46.583 [1]: trying to listen on host[::], family[10], socktype[1], proto[6]
INFO      Jul 13 11:22:46.583 [1]: listening on fd [4]
INFO      Jul 13 11:22:46.583 [1]: Not running as root, so not changing UID/GID.
INFO      Jul 13 11:22:46.583 [1]: Setting the various signals.
INFO      Jul 13 11:22:46.583 [1]: Starting main loop. Accepting connections.
CONNECT   Jul 13 11:23:02.916 [1]: Connect (file descriptor 5): 10.0.38.4
CONNECT   Jul 13 11:23:02.916 [1]: Request (file descriptor 5): CONNECT google.com:443 HTTP/1.1
INFO      Jul 13 11:23:02.916 [1]: Found upstream proxy http upstream:8888 for google.com
INFO      Jul 13 11:23:02.916 [1]: opensock: opening connection to upstream:8888
INFO      Jul 13 11:23:02.916 [1]: opensock: getaddrinfo returned for upstream:8888
CONNECT   Jul 13 11:23:02.917 [1]: Established connection to upstream proxy "upstream" using file descriptor 6.
INFO      Jul 13 11:23:03.182 [1]: Closed connection between local client (fd:5) and remote client (fd:6)
```

- Curl

```
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
HTTP/1.0 200 Connection established

  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
  0   220    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
Via: 1.1 Swarmproxy (tinyproxy/1.11.1)
Proxy-agent: tinyproxy/1.11.1

HTTP/2 301
location: https://www.google.com/
content-type: text/html; charset=UTF-8
content-security-policy-report-only: object-src 'none';base-uri 'self';script-src 'nonce-g1lolRpzk2b93t4bhY80uA' 'strict-dynamic' 'report-sample' 'unsafe-eval' 'unsafe-inline' https: http:;report-uri https://csp.withgoogle.com/csp/gws/other-hp
date: Thu, 13 Jul 2023 11:23:03 GMT
expires: Thu, 13 Jul 2023 11:23:03 GMT
cache-control: private, max-age=2592000

server: gws
content-length: 220
x-xss-protection: 0
x-frame-options: SAMEORIGIN
set-cookie: CONSENT=PENDING+481; expires=Sat, 12-Jul-2025 11:23:03 GMT; path=/; domain=.google.com; Secure
p3p: CP="This is not a P3P policy! See g.co/p3phelp for more info."
alt-svc: h3=":443"; ma=2592000,h3-29=":443"; ma=2592000
```

## Fullstack example with external secrets and config `(3-external.yml)`

### Source

> 🗄️ File: [3-upstream.yml](3-upstream.yml)

### Description

This stack is based on the previous upstream example. It's modified to show these additional features:

- Using external docker secret to set up an upstream proxy. Should be used when upstream needs authentication
- Mounting a docker config as filter file
- filtering queries by domains
- added curl-blocked service to show output if target domain is not in whitelist

### Usage

```bash
echo "google.com" | docker config create filter_file -
echo "upstream:8888" | docker secret create upstream-proxy -
docker stack deploy -c 1-minimal.yml swarmproxy-mini
```

### Container Logs

- Upstream

```
🦁 FILTER_FILE not found or set.
🦁 Final Swarmproxy config 🦁

3
Group 5123

8
Timeout 600
DefaultErrorFile "/usr/share/tinyproxy/default.html"
StatHost "tinyproxy.stats"
StatFile "/usr/share/tinyproxy/stats.html"
LogLevel Info
MaxClients 600
ViaProxyName "Swarmproxy"
Allow 127.0.0.1/8
Allow 10.0.0.0/8
🦁 Starting Tinyproxy...
args count: 3
args value: -c /app/proxy.conf -d
NOTICE    Jul 13 11:37:47.554 [1]: Initializing tinyproxy ...
NOTICE    Jul 13 11:37:47.554 [1]: Reloading config file
INFO      Jul 13 11:37:47.554 [1]: Stathost set to "tinyproxy.stats"
INFO      Jul 13 11:37:47.554 [1]: Setting "Via" header to 'Swarmproxy'
NOTICE    Jul 13 11:37:47.554 [1]: Reloading config file finished
INFO      Jul 13 11:37:47.554 [1]: listen_sock called with addr = '(NULL)'
INFO      Jul 13 11:37:47.554 [1]: trying to listen on host[0.0.0.0], family[2], socktype[1], proto[6]
INFO      Jul 13 11:37:47.554 [1]: listening on fd [3]
INFO      Jul 13 11:37:47.554 [1]: trying to listen on host[::], family[10], socktype[1], proto[6]
INFO      Jul 13 11:37:47.554 [1]: listening on fd [4]
INFO      Jul 13 11:37:47.554 [1]: Not running as root, so not changing UID/GID.
INFO      Jul 13 11:37:47.554 [1]: Setting the various signals.
INFO      Jul 13 11:37:47.554 [1]: Starting main loop. Accepting connections.
CONNECT   Jul 13 11:38:22.698 [1]: Connect (file descriptor 5): 10.0.40.4
CONNECT   Jul 13 11:38:22.699 [1]: Request (file descriptor 5): CONNECT google.com:443 HTTP/1.1
INFO      Jul 13 11:38:22.699 [1]: No upstream proxy for google.com
INFO      Jul 13 11:38:22.699 [1]: opensock: opening connection to google.com:443
INFO      Jul 13 11:38:26.704 [1]: opensock: getaddrinfo returned for google.com:443
CONNECT   Jul 13 11:38:26.708 [1]: Established connection to host "google.com" using file descriptor 6.
INFO      Jul 13 11:38:26.708 [1]: Not sending client headers to remote machine
INFO      Jul 13 11:38:26.785 [1]: Closed connection between local client (fd:5) and remote client (fd:6)
```

- Swarmproxy

```
🦁 Final Swarmproxy config 🦁

3
Group 5123

8
Timeout 600
DefaultErrorFile "/usr/share/tinyproxy/default.html"
StatHost "tinyproxy.stats"
StatFile "/usr/share/tinyproxy/stats.html"
LogLevel Info
MaxClients 600
ViaProxyName "Swarmproxy"
Allow 127.0.0.1/8
Allow 10.0.0.0/8
Upstream http upstream:8888
Filter "/app/filter"
FilterURLs Off
FilterCaseSensitive Off
FilterDefaultDeny Yes
🦁 Starting Tinyproxy...
args count: 3
args value: -c /app/proxy.conf -d
NOTICE    Jul 13 11:37:57.704 [1]: Initializing tinyproxy ...
NOTICE    Jul 13 11:37:57.704 [1]: Reloading config file
INFO      Jul 13 11:37:57.704 [1]: Stathost set to "tinyproxy.stats"
INFO      Jul 13 11:37:57.704 [1]: Setting "Via" header to 'Swarmproxy'
INFO      Jul 13 11:37:57.704 [1]: Added upstream http upstream:8888 for [default]
NOTICE    Jul 13 11:37:57.704 [1]: Reloading config file finished
INFO      Jul 13 11:37:57.704 [1]: listen_sock called with addr = '(NULL)'
INFO      Jul 13 11:37:57.704 [1]: trying to listen on host[0.0.0.0], family[2], socktype[1], proto[6]
INFO      Jul 13 11:37:57.704 [1]: listening on fd [3]
INFO      Jul 13 11:37:57.704 [1]: trying to listen on host[::], family[10], socktype[1], proto[6]
INFO      Jul 13 11:37:57.704 [1]: listening on fd [4]
INFO      Jul 13 11:37:57.704 [1]: Not running as root, so not changing UID/GID.
INFO      Jul 13 11:37:57.704 [1]: Setting the various signals.
INFO      Jul 13 11:37:57.704 [1]: Starting main loop. Accepting connections.
CONNECT   Jul 13 11:38:00.361 [1]: Connect (file descriptor 5): 10.0.39.4
CONNECT   Jul 13 11:38:00.361 [1]: Request (file descriptor 5): CONNECT amazon.com:443 HTTP/1.1
NOTICE    Jul 13 11:38:00.361 [1]: Proxying refused on filtered domain "amazon.com"
CONNECT   Jul 13 11:38:14.022 [1]: Connect (file descriptor 5): 10.0.39.4
CONNECT   Jul 13 11:38:14.022 [1]: Request (file descriptor 5): CONNECT amazon.com:443 HTTP/1.1
NOTICE    Jul 13 11:38:14.022 [1]: Proxying refused on filtered domain "amazon.com"
CONNECT   Jul 13 11:38:22.698 [1]: Connect (file descriptor 5): 10.0.39.4
CONNECT   Jul 13 11:38:22.698 [1]: Request (file descriptor 5): CONNECT google.com:443 HTTP/1.1
INFO      Jul 13 11:38:22.698 [1]: Found upstream proxy http upstream:8888 for google.com
INFO      Jul 13 11:38:22.698 [1]: opensock: opening connection to upstream:8888
INFO      Jul 13 11:38:22.698 [1]: opensock: getaddrinfo returned for upstream:8888
CONNECT   Jul 13 11:38:22.698 [1]: Established connection to upstream proxy "upstream" using file descriptor 6.
CONNECT   Jul 13 11:38:25.064 [1]: Connect (file descriptor 7): 10.0.39.4
CONNECT   Jul 13 11:38:25.064 [1]: Request (file descriptor 7): CONNECT amazon.com:443 HTTP/1.1
NOTICE    Jul 13 11:38:25.064 [1]: Proxying refused on filtered domain "amazon.com"
INFO      Jul 13 11:38:26.785 [1]: Closed connection between local client (fd:5) and remote client (fd:6)
CONNECT   Jul 13 11:38:36.285 [1]: Connect (file descriptor 5): 10.0.39.4
CONNECT   Jul 13 11:38:36.285 [1]: Request (file descriptor 5): CONNECT amazon.com:443 HTTP/1.1
NOTICE    Jul 13 11:38:36.285 [1]: Proxying refused on filtered domain "amazon.com"
```

- Curl

```
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed
HTTP/1.0 200 Connection established

  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
  0     0    0     0    0     0      0      0 --:--:--  0:00:01 --:--:--     0
  0     0    0     0    0     0      0      0 --:--:--  0:00:02 --:--:--     0
  0     0    0     0    0     0      0      0 --:--:--  0:00:03 --:--:--     0
  0     0    0     0    0     0      0      0 --:--:--  0:00:04 --:--:--     0
  0   220    0     0    0     0      0      0 --:--:--  0:00:04 --:--:--     0
Via: 1.1 Swarmproxy (tinyproxy/1.11.1)
Proxy-agent: tinyproxy/1.11.1

HTTP/2 301
location: https://www.google.com/
content-type: text/html; charset=UTF-8
content-security-policy-report-only: object-src 'none';base-uri 'self';script-src 'nonce-UGtC_QXXA9WxUVfYPZJkJA' 'strict-dynamic' 'report-sample' 'unsafe-eval' 'unsafe-inline' https: http:;report-uri https://csp.withgoogle.com/csp/gws/other-hp
date: Thu, 13 Jul 2023 11:38:26 GMT
expires: Thu, 13 Jul 2023 11:38:26 GMT
cache-control: private, max-age=2592000

server: gws
content-length: 220
x-xss-protection: 0
x-frame-options: SAMEORIGIN
set-cookie: CONSENT=PENDING+670; expires=Sat, 12-Jul-2025 11:38:26 GMT; path=/; domain=.google.com; Secure
p3p: CP="This is not a P3P policy! See g.co/p3phelp for more info."
alt-svc: h3=":443"; ma=2592000,h3-29=":443"; ma=2592000
```

- Curl-blocked

```
  % Total    % Received % Xferd  Average Speed   Time    Time     Time  Current
                                 Dload  Upload   Total   Spent    Left  Speed

  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
  0     0    0     0    0     0      0      0 --:--:-- --:--:-- --:--:--     0
HTTP/1.1 403 Filtered
curl: (56) CONNECT tunnel failed, response 403
Server: tinyproxy/1.11.1
Content-Type: text/html
Connection: close
```
