FROM chocobozzz/peertube:production
ENV DPKG_FRONTEND=noninteractive
RUN --mount=type=cache,target=/var/cache/apt,sharing=locked \
    --mount=type=cache,target=/var/lib/apt,sharing=locked \
    apt-get update && apt-get install -y --no-install-recommends \
    mesa-va-drivers \
    vainfo

COPY --chmod=755 start-with-plugin.sh /usr/local/bin/start-with-plugin.sh
CMD ["/usr/local/bin/start-with-plugin.sh"]
