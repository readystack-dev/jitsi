# Jitsi Meet stable-11248 — ReadyStack release `stable-11248-CE-ubuntu24.04-r8`

Generated 2026-11-25 from this release's build records and strategy. Statements that come from a single record name it in brackets; the others come from this release's strategy and build log.

## Release

- **Image:** `readystack/jitsi:stable-11248-CE-ubuntu24.04-r8` (linux/amd64). Index digest `sha256:ba9ea5e05d934da657980bef736785568ed658ebd640a4c30f291dbfb0fc9550` [`docs/provenance/LOCKED_DIGEST.txt`].
- **Image manifest digest:** `sha256:b1dfe9c631559da8eea17b975b163a470754fa306a8fede049bab1d6802b3e19` [`TARGET_DIGEST.txt`].
- **Upstream:** Jitsi Meet stable-11248 built from source at `stable/jitsi-meet_11248` of https://github.com/jitsi/jitsi-meet — upstream notes: https://github.com/jitsi/jitsi-meet/releases/tag/stable/jitsi-meet_11248 [`docs/provenance/BUILD_RECIPE.json`].
- **Base image:** `ubuntu:24.04`; runtime user `jitsi`.
- **Build:** `source-rebuild-node`, built offline with `--network=none`.
- **Supersedes:** ReadyStack release `stable-11248-CE-ubuntu24.04-r7`.

## What changed in this release

- Upstream version unchanged (stable-11248); ReadyStack rebuild.
- Jitsi Meet stable-11248 is unchanged from the release this supersedes (stable-11248-CE-ubuntu24.04-r7); this release rebuilds it. Changes: libssh-4 moves from 0.10.6-2ubuntu0.5 to 0.10.6-2ubuntu0.6 (USN-9187-1). Settings and ports are those of stable-11248-CE-ubuntu24.04-r7. The image keeps no data and uses no volumes: remove the old container and run this image with the same settings.

## Security status at release (measured 2026-11-24)

- **Docker Scout:** 0 fixable critical/high vulnerabilities; runs as `jitsi` (non-root); SBOM + provenance attestations present (SPDX SBOM + SLSA v1) [`docs/provenance/SCOUT_VERDICT.json`].
- **OSV cross-check:** no fixable critical/high vulnerability beyond Docker Scout's findings.
- **Signature:** cosign signature verified by ReadyStack's release gate before publishing; check it yourself with `cosign verify --key https://readystack.dev/keys/cosign.pub readystack/jitsi:stable-11248-CE-ubuntu24.04-r8` (signatures are recorded in the public Sigstore transparency log).
- **ReadyStack release check at release:** passed (ReadyStack's own test, not a Docker Scout grade). Vulnerabilities are disclosed every day and the image never changes, so it is re-checked daily, beside Docker Scout's own dated grade, at https://readystack.dev/queue.
- **Before exposing this service:** The container serves plain HTTP. Browsers block camera and microphone on plain-HTTP pages other than localhost, and XMPP credentials travel over /http-bind and /xmpp-websocket, so publish it only behind an HTTPS reverse proxy.

## Reproducibility

Rebuilds offline from this archive to the identical image digest `sha256:b1dfe9c631559da8eea17b975b163a470754fa306a8fede049bab1d6802b3e19`: run `./BUILD_OFFLINE.sh`, then `./VERIFY_OFFLINE.sh` (add `--online` to confirm the Docker Hub tag holds the same digest). Before publishing, ReadyStack rebuilt the kit with `./BUILD_OFFLINE.sh` and compared the result with the published digest [`docs/provenance/REPRO_VERIFICATION.json`], then ran `./BUILD_OFFLINE.sh` and `./VERIFY_OFFLINE.sh` from this archive (without `--online`).

## Validation

- 2 of 2 use cases passed (4 authored, 2 kept in the suite; 2 not exercised, see below) against the running image [`docs/validation/test-results.json`].
- The cases are `GET /config.js` (200), `GET /libs/lib-jitsi-meet.min.js` (200); the suite checks nothing else.
- 2 further authored checks were not exercised and are not counted above: 2 (`GET /`, `GET /ReadyStackDemoRoom`) were answered with the same page the build's test container served for a made-up path, so they could not show the path exists (listed under Not exercised in `docs/validation/FAILED_TESTS.md`).

## Known issues

- None recorded.

## Defects fixed

- 10 problems found before release and fixed before it shipped (10 by review); each is listed in `docs/defects/defects.json`.

## Verify this archive

```
sha256sum -c CHECKSUMS.sha256
./BUILD_OFFLINE.sh && ./VERIFY_OFFLINE.sh --online
cosign verify --key https://readystack.dev/keys/cosign.pub readystack/jitsi:stable-11248-CE-ubuntu24.04-r8
```

ReadyStack records every signature in the public Sigstore transparency log (Rekor), so the command needs no extra flags.

