#!/bin/bash

DATE=$(date -%Y%d%m)

yarn clean-all

npx eventlog-server remove-all

yarn fetch-all

if [ ! -d data ];
    mkdir data
fi

zip -r data/experiment-accepted-${DATE}.zip ./accepted

yarn run-experiment
