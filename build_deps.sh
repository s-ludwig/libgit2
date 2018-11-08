#!/usr/bin/env bash

set -ueo pipefail

LIBGIT2_VER=0.20.0
LIBSSH2_VER=1.8.0
LIBHTTP_VER=2.8.1
TGT_DIR="$1"
TMPDIR="$(mktemp -d "$PWD/build_libgit2.XXXXXX")"
cleanup() {
    rm -rf "$TMPDIR";
}
trap cleanup EXIT

mkdir -p "$TGT_DIR"

if ! command -v cmake &>/dev/null; then
    echo 'Missing cmake, needed to build libgit2 and libssh2.' >&2
    exit 1
fi
if command -v ninja &>/dev/null; then
    GENERATOR=-GNinja
else
    echo 'Missing ninja, falling back to cmake'"'"'s slow default build tool.' >&2
    GENERATOR=
fi

if [ ! -f "$TGT_DIR/libgit2.a" ]; then
    echo 'Building libgit2.a'
    mkdir "$TMPDIR/build_libgit2" && cd "$_"
    wget -q -O - https://github.com/libgit2/libgit2/archive/v$LIBGIT2_VER.tar.gz | tar -zxf -
    mkdir build && cd "$_"
    cmake $GENERATOR -DBUILD_SHARED_LIBS=OFF ../libgit2-$LIBGIT2_VER >/dev/null
    cmake --build . >/dev/null
    mv libgit2.a "$TGT_DIR"
fi

if [ ! -f "$TGT_DIR/libssh2.a" ]; then
    echo 'Building libssh2.a'
    mkdir "$TMPDIR/build_libssh2" && cd "$_"
    wget -q -O - https://www.libssh2.org/download/libssh2-$LIBSSH2_VER.tar.gz | tar -zxf -
    mkdir build && cd "$_"
    cmake $GENERATOR -DBUILD_EXAMPLES=OFF -DBUILD_SHARED_LIBS=OFF -DBUILD_TESTING=OFF ../libssh2-$LIBSSH2_VER >/dev/null
    cmake --build . >/dev/null
    mv src/libssh2.a "$TGT_DIR"
fi

if [ ! -f "$TGT_DIR/libhttp_parser.o" ]; then
    echo 'Building libhttp_parser.o'
    mkdir "$TMPDIR/build_libhttp_parser" && cd "$_"
    wget -q -O - https://github.com/nodejs/http-parser/archive/v$LIBHTTP_VER.tar.gz | tar -zxf -
    make -C http-parser-$LIBHTTP_VER library >/dev/null
    mv http-parser-$LIBHTTP_VER/libhttp_parser.o "$TGT_DIR"
fi
