#!/bin/bash

if [ "$1" != "" ]; then
    DATE=$1
else
    DATE=$(date -%Y%d%m)
fi

pm2 stop ecosystem.config.js

echo "Exporting cache..."
npx eventlog-server export > ./data/experiment-export-${DATE}.json

echo "Exporting service results..."
zip -r ./data/experiment-results-${DATE}.zip ../metadata-server/public/result

echo "Exporting stats..."
./bin/stats.sh > ./data/experiment-stats-${DATE}.txt