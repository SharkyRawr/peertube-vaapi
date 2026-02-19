FROM chocobozzz/peertube:production
ENV DPKG_FRONTEND noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    mesa-va-drivers \
    vainfo \
    && rm -rf /var/lib/apt/lists/*
