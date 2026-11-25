# Jitsi Meet: ReadyStack build kit

The offline build kit for the Docker image `readystack/jitsi:stable-11248-CE-ubuntu24.04-r7`. It holds what the image is built from (upstream source, base images, toolchain, pinned dependencies) and the documents, so the image can be rebuilt with no network access (`docker build --network=none`).

- Release: [stable-11248-CE-ubuntu24.04-r7](https://github.com/readystack-dev/jitsi/releases/tag/stable-11248-CE-ubuntu24.04-r7)
- Image: [`docker.io/readystack/jitsi:stable-11248-CE-ubuntu24.04-r7`](https://hub.docker.com/r/readystack/jitsi/tags), manifest digest `sha256:d23dd15235711b367099e6120cd89626fbf15b35564a98493acb1ac8e7b34336`
- Product page: https://readystack.dev/products/jitsi
- Defects: this repository's Issues (defects recorded from 25 November 2026 on) and https://readystack.dev/defects.html?product=jitsi

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
