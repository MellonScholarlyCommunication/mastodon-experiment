#!/bin/bash

if [ "$1" != "" ]; then
    DATE=$1
else
    DATE=$(date -%Y%d%m)
fi

npx eventlog-server export > ./data/experiment-export-${DATE}.json

zip -r ./data/experiment-results-${DATE}.zip ../metadata-server/public/result

./bin/stats.sh > ./data/experiment-stats-${DATE}.txt