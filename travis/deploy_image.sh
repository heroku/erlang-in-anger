#!/bin/bash

set -ex

if [[ "${TRAVIS_OS_NAME}" == "linux" && "${TRAVIS_BRANCH}" == "japanese" && "${TRAVIS_PULL_REQUEST}" == "false" ]]; then
  echo "$REGISTRY_PASSWORD" | docker login -u "$REGISTRY_USER" --password-stdin
  docker tag "$IMAGE_NAME" "${IMAGE_NAME}:latest"
  docker push "${IMAGE_NAME}:latest"
fi
