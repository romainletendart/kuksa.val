#!/bin/bash

# Copyright (c) 2016 Jorge Aparicio
# 
# Permission is hereby granted, free of charge, to any
# person obtaining a copy of this software and associated
# documentation files (the "Software"), to deal in the
# Software without restriction, including without
# limitation the rights to use, copy, modify, merge,
# publish, distribute, sublicense, and/or sell copies of
# the Software, and to permit persons to whom the Software
# is furnished to do so, subject to the following
# conditions:
# 
# The above copyright notice and this permission notice
# shall be included in all copies or substantial portions
# of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF
# ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED
# TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A
# PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT
# SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR
# IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.

# Source: https://github.com/cross-rs/cross/blob/master/docker/

# this linker wrapper works around issue https://github.com/rust-lang/rust/issues/46651
# which affects toolchains older than 1.48
# older toolchains require the `-lgcc` linker flag otherwise they fail to link

set -euo pipefail

main() {
    local release=
    release=$(rustc -Vv | grep '^release:' | cut -d ':' -f2)
    # NOTE we assume `major` is always "1"
    local minor=
    minor=$(echo "$release" | cut -d '.' -f2)

    if (( minor >= 48 )); then
        # no workaround
        aarch64-linux-musl-gcc "${@}"
    else
        # apply workaround
        aarch64-linux-musl-gcc "${@}" -lgcc
    fi
}

main "${@}"
