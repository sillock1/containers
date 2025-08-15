# syntax=docker/dockerfile:1

FROM docker.io/library/python:3.11-slim
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
  apt-get update \
    && \
    apt-get install -y --no-install-recommends --no-install-suggests \
    bash \
    ca-certificates \
    catatonit \
    coreutils \
    curl \
    jq \
    nano \
    tzdata \
    ffmpeg \
    libsm6 \
    libxext6 \ 
    && pip install --requirement "https://raw.githubusercontent.com/arvindrajan92/fastanpr/refs/tags/v${VERSION}/requirements.txt" \
    && apt-get purge -y --auto-remove -o APT::AutoRemove::RecommendsImportant=false \
    && apt-get autoremove -y \
    && apt-get clean

COPY . /

USER nobody:nogroup
WORKDIR /config
VOLUME ["/config"]

ENTRYPOINT ["/usr/bin/catatonit", "--", "/entrypoint.sh"]
