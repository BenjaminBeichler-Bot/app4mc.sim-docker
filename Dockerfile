FROM ubuntu:20.04

# Avoid warnings by switching to noninteractive
ENV DEBIAN_FRONTEND noninteractive

# Configure apt and install packages
RUN apt-get update \
    #install cmake, ninja, and icecc
    && apt-get -y install --no-install-recommends ninja-build cmake icecc git \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
    
# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND ""
ENV PATH "/usr/lib/icecc/bin:$PATH"

CMD ["bash"]
