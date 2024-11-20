#!/bin/bash

find accepted -name "*.jsonld" | xargs -I {} jq -r ".object.url[].href" {}