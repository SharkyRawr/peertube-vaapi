# peertube-vaapi

PeerTube Docker image with VA-API userspace packages preinstalled.

Base image: `chocobozzz/peertube:production`

## What this image adds

- `mesa-va-drivers`
- `vainfo`

These packages are added on top of the official PeerTube image to support VA-API hardware acceleration in compatible environments.

## Build locally

```bash
docker build -t peertube-vaapi .
```

## Run locally

```bash
docker run --rm -it peertube-vaapi vainfo
```

You may need to pass GPU devices and/or container runtime flags depending on your host setup.

## GitHub Container Registry publishing

This repository includes a GitHub Actions workflow at `.github/workflows/docker.yaml` that:

- builds a multi-arch image (`linux/amd64`, `linux/arm64`)
- pushes to `ghcr.io/<owner>/<repo>`
- generates SBOM and provenance
- publishes build attestation
- uses GitHub Actions cache for faster rebuilds

### Triggers

- Push to `main`
- Push tags matching `v*`
- Manual trigger via `workflow_dispatch`
- Scheduled polling every 6 hours checks latest release from `chocobozzz/PeerTube` and builds only when a new upstream tag appears

## License

This project is licensed under the GNU Affero General Public License v3.0.
See `LICENSE` for the full text.
