#!/bin/bash

function fetch {
    LAST_ID=$(ls ./accepted/$2/*.jsonld | head -1 | sed -e 's/.*\///' | sed -e 's/-.*.jsonld//')
    while true; do
        if [ "${LAST_ID}" == "" ]; then
            npx mastodon-cli fetch --url $1 --account $2 --limit 50 --inbox ./accepted/$2 
        else
            npx mastodon-cli fetch --older $LAST_ID --url $1 --account $2 --limit 50 --inbox ./accepted/$2 
        fi
    
        ID=$(ls ./accepted/$2/*.jsonld | head -1 | sed -e 's/.*\///' | sed -e 's/-.*.jsonld//')

        if [ "${ID}" == "${LAST_ID}" ]; then
            break
        else
            LAST_ID=$ID
        fi

        echo "next page > ${LAST_ID}..."
        sleep 2
    done
}

while IFS= read -r line || [[ -n "$line" ]]; do
    URL=${line%;*}
    ACCOUNT=${line##*;}
    echo "${ACCOUNT}@${URL}..."
    if [ ! -d ./accepted/$ACCOUNT ]; then
        mkdir ./accepted/$ACCOUNT
    fi
    fetch $URL $ACCOUNT    
done < ./config/accounts.txt