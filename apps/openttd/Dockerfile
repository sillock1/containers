# renovate: datasource=custom.openttd depName=openttd versioning=loose
ARG VERSION=14.1
# renovate: datasource=custom.opengfx depName=opengfx versioning=loose
ARG OPENGFX_VERSION=7.1
FROM docker.io/library/debian:12.8-slim
ARG VERSION
ARG OPENGFX_VERSION

WORKDIR /app

RUN apt update
RUN apt install -y \
  bash \
  curl \
  ca-certificates \
  catatonit \
  wget \
  xz-utils \
  libarchive-tools \
  libfontconfig1 \
  libfreetype6 \
  libfluidsynth3 \
  libicu-dev \
  libpng16-16 \
  liblzma-dev \
  liblzo2-2 \
  libsdl1.2debian \
  libsdl2-2.0-0


RUN mkdir -p /app/openttd \
  && curl -fsSL https://cdn.openttd.org/openttd-releases/${VERSION}/openttd-${VERSION}-linux-generic-amd64.tar.xz \
  | tar xJf - -C /tmp \
  && mv /tmp/openttd-${VERSION}-linux-generic-amd64/* /app/openttd

RUN mkdir -p /app/openttd/baseset \
  && curl -fsSL https://cdn.openttd.org/opengfx-releases/${OPENGFX_VERSION}/opengfx-${OPENGFX_VERSION}-all.zip \
  | bsdtar -xvf - -C /tmp \
  && tar xf /tmp/opengfx-${OPENGFX_VERSION}.tar -C /tmp \
  && mv /tmp/opengfx-${OPENGFX_VERSION}/* /app/openttd/baseset

COPY --chmod=755 ./apps/openttd/entrypoint.sh /entrypoint.sh
RUN chown -R nobody:nogroup /app
VOLUME ["/config"]
USER nobody:nogroup
EXPOSE 3979/tcp
EXPOSE 3979/udp

ENTRYPOINT ["catatonit", "--", "/entrypoint.sh"]
