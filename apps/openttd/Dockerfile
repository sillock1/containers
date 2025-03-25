
FROM docker.io/library/debian:12.9-slim as build

ARG TARGETARCH
ARG TARGETPLATFORM
ARG VERSION

RUN apt update && apt install -y \
  curl \
  xz-utils \
  yq \
  libarchive-tools

WORKDIR /app

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

RUN chown -R nobody:nogroup /app

FROM docker.io/library/debian:12.9-slim as final

RUN apt update && apt install -y \
  libglib2.0-0 \
  libgomp1 \
  curl \
  catatonit \
  ca-certificates \
  gettext-base

COPY --from=build /app /app
COPY ./private.cfg.tmpl /app/openttd/private.cfg.tmpl
COPY ./secrets.cfg.tmpl /app/openttd/secrets.cfg.tmpl
COPY --chmod=755 ./entrypoint.sh /entrypoint.sh

VOLUME ["/data"]

USER nobody:nogroup

EXPOSE 3979/tcp
EXPOSE 3979/udp

ENTRYPOINT ["/usr/bin/catatonit", "--", "/entrypoint.sh"]
