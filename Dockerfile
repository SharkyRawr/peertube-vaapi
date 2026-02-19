FROM chocobozzz/peertube:v8.0.2
ENV DPKG_FRONTEND noninteractive
RUN apt-get update && apt-get install -y --no-install-recommends \
    mesa-va-drivers \
    vainfo \
    && rm -rf /var/lib/apt/lists/*
