#!/bin/bash

CONTAINER_ID="$1"
SPEC_FILE="$2"
SOURCES="$3"

MNT=$(podman mount "$CONTAINER_ID")
cp "$SPEC_FILE" "$MNT/home/builder/rpmbuild/SPECS"
for SOURCE in $SOURCES; do
    cp "$SOURCE" "$MNT/home/builder/rpmbuild/SOURCES"
done
