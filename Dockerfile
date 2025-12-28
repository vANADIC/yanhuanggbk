# Force amd64 base image because the bundled FluffOS driver binary is x86_64.
FROM --platform=linux/amd64 ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive

# Runtime libraries for the prebuilt FluffOS driver. libevent/pcre major
# versions differ from what the binary expects, so provide compatibility
# symlinks.
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        libevent-2.1-7 \
        libevent-pthreads-2.1-7 \
        libpcre3 \
        zlib1g \
        libstdc++6 \
    && mkdir -p /usr/lib/x86_64-linux-gnu \
    && ln -sf "$(ldconfig -p | awk '/libevent-2\.1\.so\.7/{print $4; exit}')" /usr/lib/x86_64-linux-gnu/libevent-2.0.so.5 \
    && ln -sf "$(ldconfig -p | awk '/libpcre\.so\.3/{print $4; exit}')" /usr/lib/x86_64-linux-gnu/libpcre.so.1 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root/hellmud
COPY . /root/hellmud

EXPOSE 1234
CMD ["./bin/driver", "./bin/config.ini"]
