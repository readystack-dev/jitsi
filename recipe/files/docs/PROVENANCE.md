# Provenance — Jitsi Meet (`stable-11248-CE-ubuntu24.04-r8`)

Every item below is copied from a record in this archive; the record is named in brackets.

## Source

- Upstream repository: https://github.com/jitsi/jitsi-meet
- Revision built: `stable/jitsi-meet_11248` (commit `f765042bf280cbd7dcd4a9bbdb63b09e9e4d3259`)
- Source tree: `348e977d549628dbcb5c66aa95a57722a9fe8a1415c90680674fb63e9d1ba626` over 3159 files [`docs/provenance/SOURCE_TREE_HASH.json`]
- Community Edition only: enterprise code is removed or refused before the build (CE audit at acquire).

## Build

- Method: `source-rebuild-node`; base image `ubuntu:24.04`
- Built with `--network=none` from vendored source, dependencies and base images; BuildKit pinned to `moby/buildkit:v0.31.2` (shipped in `toolchain/`).
- SOURCE_DATE_EPOCH: `1795543181` [`SOURCE_DATE_EPOCH.txt`]
- Frozen inputs: [`docs/provenance/FREEZE_MANIFEST.json`], build recipe: [`docs/provenance/BUILD_RECIPE.json`].

## Output

- Published image: `readystack/jitsi:stable-11248-CE-ubuntu24.04-r8` — index digest `sha256:ba9ea5e05d934da657980bef736785568ed658ebd640a4c30f291dbfb0fc9550` [`docs/provenance/LOCKED_DIGEST.txt`]
- linux/amd64 image digest `sha256:b1dfe9c631559da8eea17b975b163a470754fa306a8fede049bab1d6802b3e19` — reproduced from this archive before publishing [`docs/provenance/REPRO_VERIFICATION.json`].

## Attestations and signature

- SBOM + SLSA provenance attached to the image: attached: an SPDX SBOM and SLSA v1 provenance [`docs/provenance/SCOUT_VERDICT.json`]
- cosign signature by the ReadyStack release key: verified before publishing. Check it: `cosign verify --key https://readystack.dev/keys/cosign.pub readystack/jitsi:stable-11248-CE-ubuntu24.04-r8`

## Pinned inputs, and why

- 19 pinned inputs, each with where it came from, why this one, how it was checked and when it was decided: `docs/PINS.md` [`docs/provenance/PINS.json`] (upstream source 2, base and build images 1, image digests 1, language runtimes and toolchains 1, dependency versions readystack sets 8, pins in the kit's dockerfiles 3, readystack's build engine 1, dependencies upstream chose 2).

## Build trail

- How this release passed through the ReadyStack harness, record by record (every chain, drive, stage, review round, defect and check, each naming the record it is copied from): `ReadyStack-jitsi-stable-11248-CE-ubuntu24.04-r8.trail.json`, published beside this archive and signed with the release key (`ReadyStack-jitsi-stable-11248-CE-ubuntu24.04-r8.trail.json.sigstore`), and readable at https://readystack.dev/products/jitsi/trail/stable-11248-CE-ubuntu24.04-r8.

