#!/bin/bash

find accepted -name "*.jsonld" | xargs -n 1 -I {} jq -r ".object.url[].href" {}