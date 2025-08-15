# syntax=docker/dockerfile:1

FROM docker.io/library/python:3.13-alpine3.22
ARG VERSION

ENV \
    PIP_BREAK_SYSTEM_PACKAGES=1 \
    PIP_DISABLE_PIP_VERSION_CHECK=1 \
    PIP_NO_CACHE_DIR=1 \
    PIP_ROOT_USER_ACTION=ignore \
    PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    UV_NO_CACHE=true \
    UV_SYSTEM_PYTHON=true \
    UV_EXTRA_INDEX_URL="https://wheel-index.linuxserver.io/alpine-3.22/"

USER root
WORKDIR /app

RUN \
    apk add --no-cache \
        bash \
        ca-certificates \
        catatonit \
        coreutils \
        curl \
        jq \
        nano \
        tzdata \
    && \
    apk add --no-cache --virtual .build-deps \
        build-base \
        libffi-dev \
        musl-dev \
        openssl-dev \
    && pip install uv \
    && uv pip install \
        --requirement "https://raw.githubusercontent.com/arvindrajan92/fastanpr/refs/tags/v${VERSION}/requirements.txt" \
    && mkdir -p /app \
    && curl -fsSL "https://github.com/arvindrajan92/fastanpr/archive/refs/tags/v${VERSION}.tar.gz" \
        | tar xzf - -C /app --strip-components 1 \
    && chown -R root:root /app && chmod -R 755 /app \
    && pip uninstall --yes uv && apk del --purge .build-deps \
    && rm -rf /root/.cache /tmp/*

COPY . /

USER nobody:nogroup
WORKDIR /config
VOLUME ["/config"]

ENTRYPOINT ["/usr/bin/catatonit", "--", "/entrypoint.sh"]
