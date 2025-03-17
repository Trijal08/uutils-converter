#!/usr/bin/env bash

## Make a directory for all these shenanigans then cd to it
mkdir -p uutils-src/
cd uutils-src/

## uutils coreutils
# Install some basic dependencies
sudo dnf update -y --refresh
sudo dnf install -y curl git-all pkg-config openssl-devel clang-devel llvm-devel lld-devel cc c++

# Clone the uutils coreutils source and cd to it
git clone --depth=1 https://github.com/uutils/coreutils.git
cd coreutils/

# Setup rust build dependencies
sudo dnf remove -y cargo rustc
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
source ~/.bashrc
#source ~/.profile
rustup component add cargo
rustup toolchain install stable
sudo rm /usr/bin/rustc /usr/bin/cargo
sudo ln -sf ~/.rustup/toolchains/stable-$(arch)-unknown-linux-gnu/bin/rustc /usr/bin/rustc
sudo ln -sf ~/.rustup/toolchains/stable-$(arch)-unknown-linux-gnu/bin/cargo /usr/bin/cargo

# Build the uutils coreutils from source
cargo build --release --features unix -j$(nproc --all) || exit 1

# Copy the coreutils to root bin folders, where it can be accessed and executed by the user or the superuser
sudo ./target/release/coreutils rm -f /usr/bin/uutils-coreutils
sudo ./target/release/coreutils cp ./target/release/coreutils /usr/bin/uutils-coreutils
sudo ./target/release/coreutils rm -f /usr/bin/coreutils
sudo ./target/release/coreutils ln -sf ./uutils-coreutils /usr/bin/coreutils
sudo ./target/release/coreutils cp ./target/release/coreutils /bin/uutils-coreutils
sudo ./target/release/coreutils rm -f /bin/coreutils
sudo ./target/release/coreutils ln -sf ./uutils-coreutils /bin/coreutils

# Clone the required files for full conversion from GNU coreutils to uutils coreutils
git clone --depth=1 https://github.com/Trijal08/uutils-converter.git

# Run the scripts
./target/release/coreutils chmod a+x uutils-converter/*.sh
sudo ./uutils-converter/uutils-coreutils-installer.sh
sudo rpm -e --allmatches --nodeps coreutils
sudo ./uutils-converter/uutils-coreutils-installer.sh
sudo dnf install --no-best -y ./uutils-converter/coreutils*.rpm

# Version lock the coreutils common package(s) so that it isn't updated and doesn't break the system
sudo dnf versionlock add coreutils coreutils-single

# Run some more scripts
sudo ./uutils-converter/uutils-coreutils-shell-completions.sh
sudo ./uutils-converter/uutils-coreutils-manpages.sh

# Setup the environment one last time before success!
source ~/.bashrc
#source ~/.profile

## Go back to main directory
cd ..
