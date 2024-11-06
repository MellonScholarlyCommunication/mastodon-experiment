#!/bin/bash

DATE=$(date -%Y%d%m)

npx eventlog-server export > ./data/export-${DATE}.json

zip -r ./data/metadata-server-${DATE}.zip ../metadata-server/public/result