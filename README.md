# Podman RPM builder
*This project aims to provide an way to build an RPM package from source inside a Podman container.*

# How to use
1. Create the container image: `buildah bud -t c8-rpmbuilder` (if you want to change the tag, make sure to put yours in the `build.sh` file).
2. Run `build.sh <spec> <source>...` to build the RPM package inside the container.
`<spec>` is the path to the package's SPEC file and `<source>...` are the package's sources as specified in the SPEC file.

The script will then proceed to build the package and will eventually copy the SRPM and all RPM packages that have been created.

**Files `cp-source.sh` and `cp-build.sh` are called within `build.sh` and are not supposed to be run standalone.**

# Some tips
If you want to use a SPEC file from an existing package, download the SRPM and extract it using the following command:
`mkdir <package> && rpm2cpio <package>.src.rpm | cpio -iD <package>`
