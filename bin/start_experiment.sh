#!/bin/bash

DATE=$(date -%Y%d%m)

./bin/clean_experiment.sh

pm2 stop ecosystem.config.js
pm2 start ecosystem.config.js

yarn fetch-all

if [ ! -d data ];
    mkdir data
fi

zip -r data/experiment-accepted-${DATE}.zip ./accepted
