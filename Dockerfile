FROM ubuntu:focal

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Configure apt and install packages
RUN apt-get update \
    && apt-get -y install --no-install-recommends apt-utils dialog 2>&1 \
    #install cmake prerequisites, ninja, git, ccache, ...
    && apt install -y apt-transport-https ca-certificates gnupg software-properties-common wget ninja-build gdb ccache libarchive-tools git iproute2 procps lsb-release make g++ 2>&1
    # install cmake apt repo
RUN wget https://apt.kitware.com/kitware-archive.sh \
    && bash kitware-archive.sh \
    && apt-get update \
    && apt-get -y install cmake

    # Clean up
RUN apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir /app4mc.sim && cd /app4mc.sim && git clone --depth=1 --branch develop --recursive  --shallow-submodules https://gitlab.eclipse.org/eclipse/app4mc/org.eclipse.app4mc.tools.simulation.git .
ENV APP4MCSIM_LOC="/app4mc.sim"
WORKDIR model

# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=
