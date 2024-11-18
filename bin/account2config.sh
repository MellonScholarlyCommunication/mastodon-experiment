#!/bin/bash

function a2c() {
    FILE=$1
    SLEEP=$2

    if [ -f ${FILE}.txt ]; then
      rm ${FILE}.txt
    fi

    echo "Generating ${FILE}.txt..."

    while IFS= read -r line
    do

      HOST=$(echo $line | sed -e 's/.*@//')
    
      ID=$(npx mastodon-cli account $line 2> /dev/null | jq -r ".id")

      if [ "$ID" != "" ]; then
        echo "https://${HOST};${ID}" >> ${FILE}.txt
      fi
      
      if [ "$SLEEP" != "" ]; then 
        sleep $SLEEP
      fi
    done < "$FILE"
}

FILE=$1

if [ "${FILE}" == "" ]; then
    echo "$0 : file"
    exit 1
fi

for f in $@; do
  a2c $f 0.2
done
