FROM chocobozzz/peertube:production
ENV DPKG_FRONTEND noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    mesa-va-drivers \
    vainfo \
    && rm -rf /var/lib/apt/lists/*

# Pre-install VA-API PeerTube plugin in the image
RUN npm run plugin:install -- --npm-name @lunacode/peertube-plugin-hardware-transcode-vaapi
