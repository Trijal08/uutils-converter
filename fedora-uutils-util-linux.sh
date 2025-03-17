#!/usr/bin/env bash

## Make a directory for all these shenanigans then cd to it
mkdir -p uutils-src/
cd uutils-src/

## uutils util-linux
# Install some basic dependencies
sudo dnf update -y --refresh
sudo dnf install -y curl git-all pkg-config openssl-devel clang-devel llvm-devel lld-devel util-linux cc c++

# Clone the uutils util-linux source and cd to it
git clone --depth=1 https://github.com/uutils/util-linux.git
cd util-linux/

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

# Build the uutils util-linux from source
cargo build --release -j$(nproc --all) || exit 1

# Copy the util-linux to root bin folders, where it can be accessed and executed by the user or the superuser
sudo rm -f /usr/bin/uutils-util-linux
sudo cp ./target/release/util-linux /usr/bin/uutils-util-linux
sudo rm -f /usr/bin/util-linux
sudo ln -sf ./uutils-util-linux /usr/bin/util-linux
sudo cp ./target/release/util-linux /bin/uutils-util-linux
sudo rm -f /bin/util-linux
sudo ln -sf ./uutils-util-linux /bin/util-linux

# Clone the required files for full conversion from Linux util-linux to uutils util-linux
git clone --depth=1 https://github.com/Trijal08/uutils-converter.git

# Run the scripts
chmod a+x uutils-converter/*.sh
sudo ./uutils-converter/uutils-util-linux-installer.sh
sudo rpm -e --allmatches --nodeps util-linux
sudo ./uutils-converter/uutils-util-linux-installer.sh
sudo dnf install --no-best -y ./uutils-converter/util-linux*.rpm

# Version lock the util-linux common package(s) so that it isn't updated and doesn't break the system
sudo dnf versionlock add util-linux

# Run some more scripts
sudo ./uutils-converter/uutils-util-linux-shell-completions.sh
sudo ./uutils-converter/uutils-util-linux-manpages.sh

# Setup the environment one last time before success!
source ~/.bashrc
#source ~/.profile

## Go back to main directory
cd ..
