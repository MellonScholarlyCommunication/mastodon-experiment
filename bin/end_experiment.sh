#!/bin/bash

if [ "$1" != "" ]; then
    DATE=$1
else
    DATE=$(date +%Y%m%d)
fi

pm2 stop ecosystem.config.js

echo "Exporting cache..."
npx eventlog-server --name cache export > ./data/experiment-export-${DATE}.json

echo "Exporting claims..."
npx eventlog-server --name claims export > ./data/experiment-export-claims-${DATE}.json

echo "Exporting service results..."
zip -r ./data/experiment-results-${DATE}.zip ../metadata-server/public/result

echo "Exporting wiki page..."
./bin/wiki_page.sh > experiment-wiki-${DATE}.txt

echo "Exporting stats..."
./bin/stats.sh > ./data/experiment-stats-${DATE}.txt

echo "Exporting claim stats..."
(cd ../rdf-generator ; ./stats.sh) > ./data/experiment-claim-stats-${DATE}.txt

echo "Exporting claims db..."
cp /var/www/html/exports/claims.nq ./data/exportiment-claim-dump-${DATE}.nq