#!/usr/bin/env bash

set -euo pipefail

git clone --recurse-submodules https://gitlab.haskell.org/ghc/ghc.git /workspace/ghc

pushd /workspace/ghc

cp -a /workspace/gitpod-ghc/.vscode .
./boot --hadrian
./configure
hadrian/build --build-root=.hie-bios --flavour=ghc-in-ghci --docs=none -j tool:ghc/Main.hs
haskell-language-server typecheck ghc/Main.hs
haskell-language-server typecheck hadrian/src/Main.hs

popd
