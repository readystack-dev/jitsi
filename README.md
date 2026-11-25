# Jitsi Meet: ReadyStack build kit

The offline build kit for the Docker image `readystack/jitsi:stable-11248-CE-ubuntu24.04-r7`. It holds what the image is built from (upstream source, base images, toolchain, pinned dependencies) and the documents, so the image can be rebuilt with no network access (`docker build --network=none`).

- Release: [stable-11248-CE-ubuntu24.04-r7](https://github.com/readystack-dev/jitsi/releases/tag/stable-11248-CE-ubuntu24.04-r7)
- Image: [`docker.io/readystack/jitsi:stable-11248-CE-ubuntu24.04-r7`](https://hub.docker.com/r/readystack/jitsi/tags), manifest digest `sha256:d23dd15235711b367099e6120cd89626fbf15b35564a98493acb1ac8e7b34336`
- Product page: https://readystack.dev/products/jitsi
- Source and build recipe: https://readystack.dev/products/jitsi/recipe
- Build trail: https://readystack.dev/products/jitsi/trail/stable-11248-CE-ubuntu24.04-r7
- Defects: this repository's Issues (defects recorded from 25 November 2026 on) and https://readystack.dev/defects.html?product=jitsi

## The image

Single container holding ONLY the Jitsi Meet web frontend: the browser application (built from source) served by nginx as a non-root user on port 8080, with /http-bind and /xmpp-websocket proxied to an XMPP server. It is NOT a complete Jitsi Meet: a conference also needs prosody (XMPP signalling), jicofo (conference focus) and jitsi-videobridge (the media server, UDP 10000). None of those are in this image. The environment variable names match docker-jitsi-meet's `web` service, so this container can replace that service in a docker-jitsi-meet deployment that supplies the other three.

## Who uses Jitsi Meet and why

Organisations and individuals who want to run their own video meetings.

Jitsi Meet is open-source video conferencing that works in the browser and in mobile apps, with screen sharing, chat, polls and raise-hand, and it can be embedded in other web applications.

A typical use: A school wants video lessons without sending its classes through an outside service. It runs Jitsi Meet on its own server; teachers share a meeting link, students join from a browser or the mobile app, and the teacher shares slides and runs quick polls during the lesson.

From the upstream project's own description: https://github.com/jitsi/jitsi-meet.

## This release

- Docker Scout policy grade at release: **A** (94%), graded 2026-11-22 with `docker scout policy` (CLI 1.26.0, docker-default configuration).
  - Docker Scout counts 104 packages with copyleft licences (GPL, LGPL, MPL), all of them operating-system packages (it counts only packages whose licence it can read; the SBOM lists every component).
- Signed with ReadyStack's release key (fingerprint `04daa92344a52dbc`): https://readystack.dev/keys/cosign.pub.
- Runs as a non-root user (`jitsi`).
- Attestations on the image: an SPDX SBOM and SLSA provenance v1.
- Rebuilt from this kit with network egress blocked on 2026-11-22; the rebuilt image digest is the published one.
- Base: Ubuntu 24.04.

The current grade, measured again every day, is on https://readystack.dev/products/jitsi.

Jitsi Meet is distributed under its upstream licence (Apache-2.0); the kit contains upstream's source under that licence, and each vendored component under its own.

## Download

From the [stable-11248-CE-ubuntu24.04-r7 release](https://github.com/readystack-dev/jitsi/releases/tag/stable-11248-CE-ubuntu24.04-r7): `ReadyStack-jitsi-stable-11248-CE-ubuntu24.04-r7.tar.gz` (514.2 MB), SHA-256 `20ee8c1dd13046619298ab40aa47e4504689fa0cd34915a130f87a6916148e66`.

```sh
sha256sum --check --ignore-missing SHA256SUMS
```

## Verify and rebuild

The rebuild statement is signed with the ReadyStack release key. Check the signature before you rely on it:

```sh
cosign verify-blob --key https://readystack.dev/keys/cosign.pub \
  --bundle ReadyStack-jitsi-stable-11248-CE-ubuntu24.04-r7.rebuild.json.sigstore ReadyStack-jitsi-stable-11248-CE-ubuntu24.04-r7.rebuild.json
```

Unpack with `-p` so file modes are kept, then follow the kit's own README.md and docs/REBUILD.md:

```sh
tar -xpzf ReadyStack-jitsi-stable-11248-CE-ubuntu24.04-r7.tar.gz
cd stable-11248-CE-ubuntu24.04-r7
less README.md docs/REBUILD.md
```

The build trail (`ReadyStack-jitsi-stable-11248-CE-ubuntu24.04-r7.trail.json`, signed the same way, and its Markdown copy) records how this release was built and checked.

## This repository

`recipe/` holds the kit's recipe files (Dockerfiles, build scripts, pins) as published at https://readystack.dev/products/jitsi/recipe. The complete kit is the release download. Each release is a tag here.

— ReadyStack · https://readystack.dev
