<p align="right">
  <img src="http://forthebadge.com/images/badges/built-with-love.svg">
  <img src="http://forthebadge.com/images/badges/for-you.svg">
</p>

<p align="center">
  <a href="https://gitea.ocram85.com/OCram85/swarmproxy/">
    <img
      src="/OCram85/swarmproxy/raw/branch/main/assets/social-logo.png"
      alt="Swarmproxy - Tame your traffic"
    >
  </a>
</p>

<p align="center">
🦁 Swarmproxy is a simple http proxy to limit your outbound traffic.
</p>

## 📖 About

Swarmproxy is a simply way to integrate a http proxy in your Docker swarm cluster or any other container network.
It acts as an centralized proxy to limit your outbound / egress traffic. You can also add a whitelist filter to
limit the allowed domains. There is also an option to use a upstream proxy.

### What does Swarmproxy for you?

Enterprise and production environments often face more stringent security requirements.
Therefore, unfiltered Internet access may be prohibited.

So Swarmproxy could help you with these features:

- ✔️ Prevent direct web access from Container workload.
- ✔️ Upstream proxy with or without authentication
- ✔️ Optional domain based whitelist filter.

### What does Swarmproxy not?

Swarmproxy is just a supercharged Tinyproxy where you can point your container workload to.

- ☣️ Swarmproxy does not block the web access or other traffic if you workload doesn't use a proxy
- ☣️ It's not a firewall, thus it does not customize your iptables or any other firewall policies.

## 🚀 Quickstart

### 1. ⚡ Get the image 📦

You can download the image from the Gitea embedded container registry: `gitea.ocram85.com/ocram85/swarmproxy` with these tags:

- `latest`, `main` - Is based on the lasted master branch commit.
- `1`, `0.1`, `0.1.0` - tag based version.

> **💡 NOTE: See the [packages page](https://gitea.ocram85.com/OCram85/-/packages/container/swarmproxy/latest)
> for latest version and all other available tags.**

### 2. 🛡️ Run as Docker Swarm Stack

This example shows all available configuration keys / environment variables for Swarmproxy.

```yaml
version: "3.8"

networks:
  egress:
   attachable: true
   #external: true

#configs:
#  filter_file:
#    # config can be predefined / external or loaded from file
#    #external: true
#    file: ./filter.txt

#secrets:
#  upstream-proxy:
#    external: true

services:
  swarmproxy:
    # Do not use the `latest` tag in production!
    image: gitea.ocram85.com/OCram85/swarmproxy:latest
    deploy:
      replicas: 1
    #secrets:
    #  - upstream-proxy
    environment:
      - LOGLEVEL=Info
      # Recommended settings
      # Use an optional upstream proxy
      #- UPSTREAM_PROXY=
      # Set UPSTREAM_PROXY as docker secret if your upstream needs authentication
      # Eg.: http://user:password@upstream.intra:3128
      #- UPSTREAM_PROXY_FILE=/run/secrets/UPSTREAM_PROXY

      # OPTIONAL config keys
      #- TINYPROXY_UID=5123
      #- TINYPROXY_GID=5123
      #- PORT=8888
      #- TIMEOUT=600
      #- MAXCLIENTS=600
      #- FILTER_FILE=/app/filter
    volumes:
      # You can mount a single filter file into the container.
      # To reload the file use the docker kill -s USR1 <container_id| container_name> command.
      # - ./filter.txt:/app/filter:ro
    #configs:
    #  - source: filter_file
    #    target: /app/filter
    networks:
      egress:
        aliases:
          - swarmproxy
          - proxy
```

## 🚀 Examples

See the [Readme](examples/) docs in the examples folder...

## 💣 Known Issues

## 😡 We're Using GitHub Under Protest

This project is currently **mirrored** to GitHub. This is not ideal; GitHub is a
proprietary, trade-secret system that is not Free and Open Source Software
(FOSS). We are deeply concerned about using a proprietary system like GitHub
to develop our FOSS project. We have an
[open Gitea repository ](https://gitea.ocram85.com/OCram85/swarmproxy/issues) where the
project contributors are actively discussing how we can move away from GitHub
in the long term. We urge you to read about the
[Give up GitHub](https://GiveUpGitHub.org) campaign from
[the Software Freedom Conservancy](https://sfconservancy.org) to understand
some of the reasons why GitHub is not a good place to host FOSS projects.

If you are a contributor who personally has already quit using GitHub, please
[check this resource](https://gitea.ocram85.com/OCram85/swarmproxy) for how to send us contributions without
using GitHub directly.

Any use of this project's code by GitHub Copilot, past or present, is done
without our permission.  We do not consent to GitHub's use of this project's
code in Copilot.

![Logo of the GiveUpGitHub campaign](https://sfconservancy.org/img/GiveUpGitHub.png)

## 🙏 Credits

Swarmproxy is based on the following projects and wouldn't be possible without them:

- [Tinyproxy](https://github.com/tinyproxy/tinyproxy) - The Tinyproxy project itself
- [docker-tinyproxy](https://github.com/kalaksi/docker-tinyproxy) - A containerized Tinyproxy variant.
- [docker-tinyproxy](https://github.com/ajoergensen/docker-tinyproxy) - A containerized Tinyproxy variant.

## ⚖️ License (AGPLv3)

![AGPL](https://www.gnu.org/graphics/agplv3-155x51.png)

```
Swarmproxy - A simple http/https proxy for outbound traffic in a docker swarm cluster.
Copyright (C) 2023 "OCram85 <me@ocram85.com>"

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU Affero General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Affero General Public License for more details.

You should have received a copy of the GNU Affero General Public License
along with this program.  If not, see <https://www.gnu.org/licenses/>.
```
