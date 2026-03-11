#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
IMAGE_TAG=${1:-latest}

sed "s/IMAGE_TAG/${IMAGE_TAG}/g" "${SCRIPT_DIR}/deployment.yaml" > "${SCRIPT_DIR}/rendered-deployment.yaml"

echo "Generated ${SCRIPT_DIR}/rendered-deployment.yaml with image tag: ${IMAGE_TAG}"
