
FROM docker.io/library/debian:13.1-slim as build

ARG TARGETPLATFORM
ARG VERSION

RUN apt update && apt install -y \
  curl \
  xz-utils \
  yq \
  libarchive-tools \
  libglib2.0-0 \
  libgomp1 \
  curl \
  catatonit \
  ca-certificates \
  gettext-base

WORKDIR /app

RUN mkdir -p /app \
  && \
  case "${TARGETPLATFORM}" in \
  'linux/amd64') export ARCH='amd64' ;; \
  esac \
  && curl -fsSL https://cdn.openttd.org/openttd-releases/${VERSION}/openttd-${VERSION}-linux-generic-${ARCH}.tar.xz \
  | tar xJf - -C /tmp \
  && mv /tmp/openttd-${VERSION}-linux-generic-amd64/* /app

RUN mkdir -p /app/baseset \
  && curl -sX GET https://cdn.openttd.org/opengfx-releases/latest.yaml \
  | yq .latest[0].version \
  | xargs -I {} curl -fsSL https://cdn.openttd.org/opengfx-releases/{}/opengfx-{}-all.zip \
  | bsdtar -xvf - -C /tmp \
  && tar xf /tmp/opengfx*.tar -C /tmp \
  && mv /tmp/opengfx*/* /app/baseset \
  && rm -rf /tmp/* \
  && apt-get autoremove -y \
  && apt-get clean \
  && chmod -R 755 /app

COPY . /

USER nobody:nogroup
WORKDIR /data
VOLUME ["/data"]

EXPOSE 3979/tcp
EXPOSE 3979/udp

ENTRYPOINT ["/usr/bin/catatonit", "--", "/entrypoint.sh"]
