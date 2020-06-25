FROM ubuntu:20.04

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND=noninteractive

# Configure apt and install packages
RUN apt update \
    && apt upgrade \
    && apt install -y --no-install-recommends apt-utils dialog 2>&1 \
    #install cmake prerequisites, ninja, and icecc
    && apt install -y sudo apt-transport-https ca-certificates gnupg software-properties-common wget ninja-build icecc gdb git iproute2 procps lsb-release \
    # install cmake apt repo
    && wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | apt-key add - \
    && apt-add-repository 'deb https://apt.kitware.com/ubuntu/ focal main' \
    # install recent llvm version for clangd
    && bash -c "$(wget -O - https://apt.llvm.org/llvm.sh)" \
    && apt-get update \
    && apt-key --keyring /etc/apt/trusted.gpg del C1F34CDD40CD72DA \
    && apt install -y clang-format clang-tidy clang-tools clang clangd libc++-dev libc++1 libc++abi-dev libc++abi1 libclang-dev libclang1 liblldb-dev libllvm-ocaml-dev libomp-dev libomp5 lld lldb llvm-dev llvm-runtime llvm python-clang kitware-archive-keyring cmake \
   


# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=
ENV PATH "/usr/lib/icecc/bin:$PATH"
