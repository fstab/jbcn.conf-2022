#!/bin/bash

GRAFANA_VERSION=9.0.2
LOGFILE=logs/$(date '+%Y-%m-%d')-grafana.log

echo >> "$LOGFILE"
echo "$(date)" >> "$LOGFILE"
echo >> "$LOGFILE"

cd bin/grafana-$GRAFANA_VERSION
./bin/grafana-server -config ../../config-grafana.ini 2>&1 | tee -a "../../$LOGFILE"
