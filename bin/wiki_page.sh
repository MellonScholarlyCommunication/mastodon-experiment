#!/bin/bash

source .env

WIKI_ID=$(npx wikijs resolve https://wiki.mycontributions.info/en/researcher/orcid/0000-0000-0000-0010 | jq -r ".id")

npx wikijs get-page --text $WIKI_ID