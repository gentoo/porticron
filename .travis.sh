#! /bin/bash
# Copyright (C) 2017 Sebastian Pipping <sebastian@pipping.org>
# Licensed under the 3-Clause BSD license
set -e

PS4='# '
set -x


# Install BATS that the test suite relies on
git clone --depth 1 https://github.com/sstephenson/bats.git
( cd bats && sudo ./install.sh /usr/local )


# Run test suite
./test.bats
