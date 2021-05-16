#!/bin/bash

IMAGE_TAG="c8-rpmbuilder"

usage() {
    cat <<EOF
usage: $0 <spec> <source>...
    spec: SPEC file
    source: source of the package (can be a file, an archive, etc.)
EOF
    exit "$1"
}

[ "$#" -lt 2 ] && usage 1
SPEC_FILE_PATH="$1"
SPEC_FILE=$(basename "$SPEC_FILE_PATH")
shift
SOURCES="$@"

# Run container
CONTAINER_ID=$(podman run -d --userns keep-id "$IMAGE_TAG")

# Copy SPEC and sources files to the container
# It use podman mount instead of podman cp so it is much quicker
podman unshare ./cp-source.sh "$CONTAINER_ID" "$SPEC_FILE_PATH" "$SOURCES"

# Install package's build dependencies
podman exec --user root "$CONTAINER_ID" dnf builddep -y "SPECS/$SPEC_FILE"

# Build package
podman exec "$CONTAINER_ID" rpmbuild -ba "SPECS/$SPEC_FILE"

# Copy resulting RPM/SRPM to the current directory
podman unshare ./cp-build.sh "$CONTAINER_ID"

podman rm -f "$CONTAINER_ID"
