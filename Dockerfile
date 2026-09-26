FROM chocobozzz/peertube:production
ENV NVIDIA_DRIVER_CAPABILITIES=video,compute,utility
ENV DPKG_FRONTEND=noninteractive
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    sed -i 's/ main/ main non-free/g' /etc/apt/sources.list /etc/apt/sources.list.d/*.sources 2>/dev/null; \
    apt-get update && apt-get install -y --no-install-recommends \
    $([ "$(dpkg --print-architecture)" = amd64 ] && echo intel-media-va-driver-non-free libvpl-tools libmfx-gen1.2) \
    mesa-va-drivers va-driver-all vainfo v4l-utils \
    mesa-vulkan-drivers vulkan-tools mesa-opencl-icd clinfo \
    libavformat-extra libavcodec-extra libavfilter-extra

COPY --chmod=755 start-with-plugin.sh /usr/local/bin/start-with-plugin.sh
CMD ["/usr/local/bin/start-with-plugin.sh"]
