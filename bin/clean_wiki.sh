#!/bin/bash

. .env

if [ "${DEMO_PROFILE}" == "" ]; then
    echo "No DEMO_PROFILE set"
    exit 1
fi

if [ "${WIKIJS_URL}" == "" ]; then
    echo "No WIKIJS_URL set"
    exit 1
fi

if [ "${WIKIJS_ACCESS_TOKEN}" == "" ]; then
    echo "No WIKIJS_ACCESS_TOKEN set"
    exit 1
fi

if [ "${CONTENT_TAG}" == "" ]; then
    echo "No CONTENT_TAG set"
    exit 1
fi

DEMO_ID=$(npx wikijs resolve ${DEMO_PROFILE} | jq -r .id)

if [ ${DEMO_ID} == "" ]; then
    echo "No ${DEMO_PROFILE} found at wiki"
    exit 2
fi

npx wikijs get-page --text ${DEMO_ID} > .wiki.output

npx updater --tag "${CONTENT_TAG}" --overwrite .wiki.output /dev/null > .wiki.update

npx wikijs update-page --text ${DEMO_ID} .wiki.update

rm .wiki.output 
rm .wiki.update