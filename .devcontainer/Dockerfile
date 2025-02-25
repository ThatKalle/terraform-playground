FROM mcr.microsoft.com/devcontainers/base:bookworm

USER root

RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
    && apt-get -y install --no-install-recommends \
    ca-certificates \
    curl \
    git \
    gnupg2 \
    gpg  \
    wget \
    zip \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

USER vscode

HEALTHCHECK NONE
