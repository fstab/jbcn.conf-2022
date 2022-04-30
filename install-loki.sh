#!/bin/bash

set -e

LOKI_VERSION=2.6.0

if [[ ! -f downloads/loki-linux-amd64.zip ]] ; then
    cd downloads
    echo downloading loki-linux-amd64.zip
    curl -sOL "https://github.com/grafana/loki/releases/download/v$LOKI_VERSION/loki-linux-amd64.zip"
    cd ..
fi

if [[ ! -x bin/loki-linux-amd64 ]] ; then
    cd bin
    unzip -q ../downloads/loki-linux-amd64.zip
    cd ..
fi
