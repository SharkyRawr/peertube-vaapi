# peertube-vaapi

PeerTube Docker image with codec libraries and hardware acceleration userspace packages preinstalled.

Base image: `chocobozzz/peertube:production`

## What this image adds

- Intel media: `intel-media-va-driver-non-free`, `libvpl-tools`, `libmfx-gen1.2` (`amd64` only; the non-free driver uses Debian's `non-free` repository)
- VA-API: `va-driver-all`, `mesa-va-drivers`, `vainfo`
- V4L2: `v4l-utils`
- Vulkan: `mesa-vulkan-drivers`, `vulkan-tools`
- OpenCL: `mesa-opencl-icd`, `clinfo`
- FFmpeg libraries: `libavcodec-extra`, `libavformat-extra`, `libavfilter-extra`
- NVIDIA container runtime capabilities: `NVIDIA_DRIVER_CAPABILITIES=video,compute,utility`
- [`peertube-plugin-lunacode-vaapi`](https://www.npmjs.com/package/peertube-plugin-lunacode-vaapi) (the sister plugin to this Docker image, auto-installed on container startup)

These additions are layered on top of the official PeerTube image to broaden codec and hardware acceleration support. Available acceleration depends on the host GPU, drivers, and devices passed to the container; the NVIDIA capabilities setting applies when using the NVIDIA container runtime.

## Build locally

```bash
docker build -t peertube-vaapi .
```

## Run locally

```bash
docker run --rm -it peertube-vaapi vainfo
```

You may need to pass GPU devices and/or container runtime flags depending on your host setup.

The plugin is installed when the container starts (not during `docker build`), because PeerTube plugin installation requires a live database connection.

## GitHub Container Registry publishing

This repository includes a GitHub Actions workflow at `.github/workflows/docker.yaml` that:

- builds a multi-arch image (`linux/amd64`, `linux/arm64`)
- pushes to `ghcr.io/<owner>/<repo>`
- generates SBOM and provenance
- publishes build attestation
- uses GitHub Actions cache for faster rebuilds

### Triggers

- Push to `main`
- Push tags matching `production`
- Manual trigger via `workflow_dispatch`
- Scheduled polling checks Docker Hub tag `chocobozzz/peertube:production` and builds only when its digest changes

## License

This project is licensed under the GNU Affero General Public License v3.0.
See `LICENSE` for the full text.
