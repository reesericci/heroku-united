#!/bin/bash

cp example.env .env
if command -v docker &> /dev/null; then
  sed -i "sSECRET_KEY_BASE=.*$SECRET_KEY_BASE=$(docker run -it --rm intel/qat-crypto-base:qatsw-ubuntu openssl rand -base64 48)" .env
  sed -i "sRAILS_MASTER_KEY=.*$RAILS_MASTER_KEY=$(docker run -it --rm intel/qat-crypto-base:qatsw-ubuntu openssl rand -base64 48)" .env
elif command -v podman &> /dev/null; then
  sed -i "sSECRET_KEY_BASE=.*$SECRET_KEY_BASE=$(podman run -it --rm docker.io/intel/qat-crypto-base:qatsw-ubuntu openssl rand -base64 48)" .env
  sed -i "sRAILS_MASTER_KEY=.*$RAILS_MASTER_KEY=$(podman run -it --rm docker.io/intel/qat-crypto-base:qatsw-ubuntu openssl rand -base64 48)" .env
else
  echo "could not find docker or podman."
  exit 1
fi