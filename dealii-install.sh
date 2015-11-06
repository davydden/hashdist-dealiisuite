#!/bin/bash
#
# This script installs deal.ii via HashDist.

# Check operating system
OS=$(uname)

# Check for git
hash git 2>/dev/null || \
{
    echo >&2 "This script requires git to run."
    echo >&2 "Try 'apt-get install git'"
    exit 1
}

# Check for wget and curl
if hash wget > /dev/null 2>&1; then
    FETCH="wget -qO-"
elif hash curl > /dev/null 2>&1; then
    FETCH="curl -s"
else
    echo >&2 "This script requries either curl or wget to run."
    exit 1
fi

# Download HashDist
if [ ! -d "hashdist" ]; then
  echo "Downloading HashDist..."
  git clone https://github.com/hashdist/hashdist.git
fi

# Download HashStack
if [ ! -d "hashstack" ]; then
  echo "Downloading HashStack..."
  git clone https://github.com/hashdist/hashstack.git
fi

# Run hit init-home to initialize hashdist directory if it does not exist
if [ ! -d $HOME/.hashdist ]; then
    ./hashdist/bin/hit init-home
fi

# Select profile
if   [ "x$OS" = "xLinux" ]; then
    HASHDIST_PROFILE="dealii.Linux.yaml"
#elif [ "x$OS" = "xDarwin" ]; then
#    HASHDIST_PROFILE="dealii.Darwin.yaml"
#elif [ "x$OS" = "xCYGWIN_NT-6.1" ]; then
#    HASHDIST_PROFILE="dealii.Cygwin.yaml"
else
    echo "*** Unsupported operating system: $OS"
    exit 1
fi

cp ${HASHDIST_PROFILE} default.yaml

echo "Using HashDist profile ${HASHDIST_PROFILE}."
echo ""

# Start installation
echo "Starting build..."
./hashdist/bin/hit build -j 4

