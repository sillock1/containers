
ARG VERSION
FROM docker.io/library/debian:12.8-slim
ARG VERSION

WORKDIR /app

RUN apt update && apt install -y \
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
  && curl -sX GET https://cdn.openttd.org/opengfx-releases/latest.yaml \
  | yq .latest[0].version \
  | xargs -I {} curl -fsSL https://cdn.openttd.org/opengfx-releases/{}/opengfx-{}-all.zip \
  | bsdtar -xvf - -C /tmp \
  && tar xf /tmp/opengfx*.tar -C /tmp \
  && mv /tmp/opengfx*/* /app/openttd/baseset

COPY --chmod=755 ./apps/openttd/entrypoint.sh /entrypoint.sh
RUN chown -R nobody:nogroup /app

VOLUME ["/config"]

USER nobody:nogroup

EXPOSE 3979/tcp
EXPOSE 3979/udp

ENTRYPOINT ["catatonit", "--", "/entrypoint.sh"]
