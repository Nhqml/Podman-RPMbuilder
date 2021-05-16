FROM centos:8

# Enable useful repositories and install packages
RUN dnf install -y rpm-build rpm-devel rpmdevtools dnf-plugins-core
RUN dnf install -y epel-release || echo -e '\033[1;33mWARNING: EPEL repo could not be installed!\033[0m'
RUN dnf config-manager --enable plus powertools
RUN dnf install -y make gcc patch

# Create user
RUN useradd -m builder

# Setup the RPM build tree
USER builder
RUN rpmdev-setuptree

WORKDIR /home/builder/rpmbuild

# Run container until stopped
CMD exec /bin/bash -c "trap : TERM INT; sleep infinity & wait"
