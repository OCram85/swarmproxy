<p align="right">
  <img src="http://forthebadge.com/images/badges/built-with-love.svg">
  <img src="http://forthebadge.com/images/badges/for-you.svg">
</p>

<p align="center">
  <a href="https://gitea.ocram85.com/OCram85/swarmproxy/">
    <img
      src="/OCram85/swarmproxy/raw/branch/main/assets/social-logo.png"
      alt="swarmproxy"
    >
  </a>
</p>

<h1 align="center">
  swarmproxy
</h1>

<p align="center">
  Swarmproxy is a simple http/https proxy for outbound traffic in a docker swarm cluster.
</p>

## :book: About

## 🤖 Quickstart

### 1. ⚡ Get the image 📦

You can download the image from the gitea embedded container registry: `gitea.ocram85.com/ocram85/swarmproxy` with these tags:

- `latest` - Is based on the lasted master branch commit.
- `next` - Is a test build based on the pull request
- `1`, `0.1`, `0.1.0` - tag based version.

> **💡 NOTE: See the [packages page](https://gitea.ocram85.com/OCram85/-/packages/container/swarmproxy/latest) for latest version and all other available tags.**

### 2.a Run as Docker Swarm Stack

```yaml
version: "3.8"

secrets:
  upstream-proxy:
    external: true

services:
  swarmproxy:
    image: gitea.ocram85.com/OCram85/swarmproxy:latest
    environment:
      # mandatory environment variables
      - UPSTREAM_PROXY=
      # Set UPSTREAM_PROXY as docker secret if your upstream needs authentication
      # Eg.: http://user:password@upstream.intra:3128
      #- UPSTREAM_PROXY_FILE=/run/secrets/UPSTREAM_PROXY

      # optional settings
      #- TINYPROXY_UID=5123
      #- TINYPROXY_GID=5123
      #- PORT=8888
      #- TIMEOUT=600
      #- LOGLEVEL=Info
      #- MAXCLIENTS=600
      #- FILTER_FILE=/ety/tinyproxy/filter
    deploy:
      replicas: 1
    volumes:
      # mount a single file into the container if you need the modify it afterwards
      # You can reload the file with `kill -s USR1 $(pidof tinyproxy)`
      - ./filter.txt:/etc/tinyproxy/filter:ro
      # Use a docker config or volume in production
      - 
    networks:
      - egress

networks:
  egress:
   attachable: true
   #external: true
```

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

swarmproxy is based on the following projects and wouldn't be possible without them:

- [Tinyproxy](https://github.com/tinyproxy/tinyproxy) - The Tinyproxy project itself
- [docker-tinyproxy](https://github.com/kalaksi/docker-tinyproxy) - A containerized tinyproxy variant.
- [docker-tinyproxy](https://github.com/ajoergensen/docker-tinyproxy) - A containerized tinyproxy variant.

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
