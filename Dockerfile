from debian:bookworm-slim

# Install build tools
RUN apt update && apt install -y \
    build-essential \
    cmake \
    ninja-build \
    git \
    python3 \
    python3-pip

# Install installing dependencies
RUN apt update && apt install -y \
    wget \
    gnupg \
    unzip \
    software-properties-common

# Install LLVM-17 and CLang-17
RUN wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key | apt-key add - \
    && add-apt-repository 'deb http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-17 main' \
    && add-apt-repository 'deb-src http://apt.llvm.org/bookworm/ llvm-toolchain-bookworm-17 main' \
    && apt update && apt install -y \
    clang-17 \
    clangd-17 \
    lld-17 \
    llvm-17 \
    libc++-17-dev \
    libc++abi-17-dev

# Install clangd-index tools
RUN wget -O clangd_indexing_tools.zip https://github.com/clangd/clangd/releases/download/17.0.3/clangd_indexing_tools-linux-17.0.3.zip \
    && unzip clangd_indexing_tools.zip \
    && mv clangd_17.0.3/bin/* /usr/local/bin \
    && mv clangd_17.0.3/lib/* /usr/local/lib \
    && rm -rf clangd_17.0.3 \
    && rm clangd_indexing_tools.zip

# Remove apt cache
RUN apt clean && rm -rf /var/lib/apt/lists/*
