#!/bin/bash
set -e

IMAGE_TAG=${1:-latest}

sed "s/IMAGE_TAG/${IMAGE_TAG}/g" deployment.yaml > rendered-deployment.yaml

echo "Generated rendered-deployment.yaml with image tag: ${IMAGE_TAG}"
