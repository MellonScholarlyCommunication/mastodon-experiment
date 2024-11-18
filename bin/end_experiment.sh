#!/bin/bash

DATE=$(date -%Y%d%m)

npx eventlog-server export > ./data/experiment-export-${DATE}.json

zip -r ./data/experiment-results-${DATE}.zip ../metadata-server/public/result