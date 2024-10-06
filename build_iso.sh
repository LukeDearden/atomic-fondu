mkdir ./iso-output
rm ./iso-output/*
sudo podman run --rm --privileged --volume ./iso-output:/build-container-installer/build --security-opt label=disable --pull=newer \
ghcr.io/jasonn3/build-container-installer:latest \
IMAGE_REPO=ghcr.io/lukedearden \
VERSION=41 \
IMAGE_NAME=atomic-fondu \
IMAGE_TAG=41 \
VARIANT=base-main # should match the variant your image is based on