[![ReadyStack](https://readystack.dev/logo.svg)](https://readystack.dev)

**Stable, Open-source Releases, Automated** · [readystack.dev](https://readystack.dev)

[![Docker Hub](https://img.shields.io/badge/Docker%20Hub-readystack%2Fjitsi-2496ED?logo=docker&logoColor=white)](https://hub.docker.com/r/readystack/jitsi) [![Docker pulls](https://img.shields.io/docker/pulls/readystack/jitsi)](https://hub.docker.com/r/readystack/jitsi) [![Grade at release](https://img.shields.io/badge/grade%20at%20release-A%20%2894%25%29-2ea44f)](https://readystack.dev/products/jitsi) [![Signed: cosign](https://img.shields.io/badge/signed-cosign-2ea44f)](https://readystack.dev/keys/cosign.pub) ![SBOM: SPDX](https://img.shields.io/badge/SBOM-SPDX-2ea44f) ![Provenance: SLSA v1](https://img.shields.io/badge/provenance-SLSA%20v1-2ea44f) ![Offline rebuild: verified](https://img.shields.io/badge/offline%20rebuild-verified-2ea44f)

# Jitsi Meet: ReadyStack build kit

The offline build kit for the Docker image `readystack/jitsi:stable-11248-CE-ubuntu24.04-r8`. It holds what the image is built from (upstream source, base images, toolchain, pinned dependencies) and the documents, so the image can be rebuilt with no network access (`docker build --network=none`).

- Release: [stable-11248-CE-ubuntu24.04-r8](https://github.com/readystack-dev/jitsi/releases/tag/stable-11248-CE-ubuntu24.04-r8)
- Image: [`docker.io/readystack/jitsi:stable-11248-CE-ubuntu24.04-r8`](https://hub.docker.com/r/readystack/jitsi/tags), manifest digest `sha256:b1dfe9c631559da8eea17b975b163a470754fa306a8fede049bab1d6802b3e19`
- Product page: https://readystack.dev/products/jitsi
- Source and build recipe: https://readystack.dev/products/jitsi/recipe
- Build trail: https://readystack.dev/products/jitsi/trail/stable-11248-CE-ubuntu24.04-r8
- Defects: this repository's Issues (defects recorded from 25 November 2026 on) and https://readystack.dev/defects.html?product=jitsi

## The image

Single container holding ONLY the Jitsi Meet web frontend: the browser application (built from source) served by nginx as a non-root user on port 8080, with /http-bind and /xmpp-websocket proxied to an XMPP server. It is NOT a complete Jitsi Meet: a conference also needs prosody (XMPP signalling), jicofo (conference focus) and jitsi-videobridge (the media server, UDP 10000). None of those are in this image. The environment variable names match docker-jitsi-meet's `web` service, so this container can replace that service in a docker-jitsi-meet deployment that supplies the other three.

## Who uses Jitsi Meet and why

Organisations and individuals who want to run their own video meetings.

Jitsi Meet is open-source video conferencing that works in the browser and in mobile apps, with screen sharing, chat, polls and raise-hand, and it can be embedded in other web applications.

A typical use: A school wants video lessons without sending its classes through an outside service. It runs Jitsi Meet on its own server; teachers share a meeting link, students join from a browser or the mobile app, and the teacher shares slides and runs quick polls during the lesson.

From the upstream project's own description: https://github.com/jitsi/jitsi-meet.

## This release

- Docker Scout policy grade at release: **A** (94%), graded 2026-11-25 with `docker scout policy` (CLI 1.26.0, docker-default configuration).
  - Docker Scout counts 104 packages with copyleft licences (GPL, LGPL, MPL), all of them operating-system packages (it counts only packages whose licence it can read; the SBOM lists every component).
- Signed with ReadyStack's release key (fingerprint `04daa92344a52dbc`): https://readystack.dev/keys/cosign.pub.
- Runs as a non-root user (`jitsi`).
- Attestations on the image: an SPDX SBOM and SLSA provenance v1.
- Rebuilt from this kit with network egress blocked on 2026-11-25; the rebuilt image digest is the published one.
- Base: Ubuntu 24.04.

The current grade, measured again every day, is on https://readystack.dev/products/jitsi.

Jitsi Meet is distributed under its upstream licence (Apache-2.0); the kit contains upstream's source under that licence, and each vendored component under its own.

## Download

From the [stable-11248-CE-ubuntu24.04-r8 release](https://github.com/readystack-dev/jitsi/releases/tag/stable-11248-CE-ubuntu24.04-r8): `ReadyStack-jitsi-stable-11248-CE-ubuntu24.04-r8.tar.gz` (514.2 MB), SHA-256 `1c88255da594908a8aa138e1c57a694bd4075feb2ddff998eb0249682f2b064c`.

```sh
sha256sum --check --ignore-missing SHA256SUMS
```

## Verify and rebuild

The rebuild statement is signed with the ReadyStack release key. Check the signature before you rely on it:

```sh
cosign verify-blob --key https://readystack.dev/keys/cosign.pub \
  --bundle ReadyStack-jitsi-stable-11248-CE-ubuntu24.04-r8.rebuild.json.sigstore ReadyStack-jitsi-stable-11248-CE-ubuntu24.04-r8.rebuild.json
```

Unpack with `-p` so file modes are kept, then follow the kit's own README.md and docs/REBUILD.md:

```sh
tar -xpzf ReadyStack-jitsi-stable-11248-CE-ubuntu24.04-r8.tar.gz
cd stable-11248-CE-ubuntu24.04-r8
less README.md docs/REBUILD.md
```

The build trail (`ReadyStack-jitsi-stable-11248-CE-ubuntu24.04-r8.trail.json`, signed the same way, and its Markdown copy) records how this release was built and checked.

## This repository

`recipe/` holds the kit's recipe files (Dockerfiles, build scripts, pins) as published at https://readystack.dev/products/jitsi/recipe. The complete kit is the release download. Each release is a tag here. How to report a vulnerability: [SECURITY.md](SECURITY.md).

## About ReadyStack

**Stable, Open-source Releases, Automated.** ReadyStack releases popular open-source apps every week with every available critical and high security fix applied, plus full documentation, reference data, tests and a build recipe that recreates each release bit-for-bit. Each release is rebuilt from its pinned inputs with the network off, checked against its published digest, signed, and scanned and graded again every day. The images and build kits are free, and ReadyStack is soon to be a nonprofit.

[readystack.dev](https://readystack.dev) · [All products](https://readystack.dev/products.html) · [Build kits on GitHub](https://github.com/readystack-dev) · [Defect log](https://readystack.dev/defects.html) · contact@readystack.dev

— ReadyStack · https://readystack.dev
