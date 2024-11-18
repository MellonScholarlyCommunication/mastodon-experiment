#!/bin/bash

FILE=$1

if [ "${FILE}" == "" ]; then
    echo "$0 : file"
    exit 1
fi

while IFS= read -r line
do

  HOST=$(echo $line | sed -e 's/.*@//')
 
  ID=$(npx mastodon-cli account $line 2> /dev/null | jq -r ".id")

  if [ "$ID" != "" ]; then
    echo "https://${HOST};${ID}"
  fi
done < "$FILE"