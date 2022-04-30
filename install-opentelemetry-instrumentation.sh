#!/bin/bash

set -e

OPENTELEMETRY_VERSION=1.15.0

if [[ ! -f downloads/opentelemetry-javaagent.jar ]] ; then
    echo installing opentelemetry Java instrumewntation
    cd downloads
    curl -sLO https://github.com/open-telemetry/opentelemetry-java-instrumentation/releases/download/v$OPENTELEMETRY_VERSION/opentelemetry-javaagent.jar
    cd ..
fi

if [[ ! -f bin/opentelemetry-javaagent.jar ]] ; then
    cp downloads/opentelemetry-javaagent.jar bin/opentelemetry-javaagent.jar
fi
