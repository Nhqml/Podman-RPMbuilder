#!/bin/bash

CONTAINER_ID="$1"

MNT=$(podman mount "$CONTAINER_ID")
find "$MNT/home/builder/rpmbuild/" -name "*.rpm" -exec cp {} . \;
