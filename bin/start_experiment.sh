#!/bin/bash

DATE=$(date -%Y%d%m)

echo "Stopping ecosystem..."
pm2 stop ecosystem.config.js

echo "Starting ecosystem..."
pm2 start ecosystem.config.js

echo "Fetching toots for researchers..."
yarn fetch-all

if [ ! -d data ];
    mkdir data
fi

echo "Archiving accepted toots in data/experiment-accepted-${DATE}.zip ..."
zip -r data/experiment-accepted-${DATE}.zip ./accepted

echo "Now you can run: yarn run-experiment or yarn run-one"
echo "Doei!"