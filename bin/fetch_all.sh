#!/bin/bash

ACCOUNTS_FILE=./config/accounts.txt
DEFAULT_MAX_COUNT_PER_ACCOUNT=20

function fetch {
    LAST_ID=$(ls ./accepted/$2/*.jsonld | head -1 | sed -e 's/.*\///' | sed -e 's/-.*.jsonld//')
    while true; do
        if [ "${LAST_ID}" == "" ]; then
            npx mastodon-cli fetch --url $1 --account $2 --limit 50 --inbox ./accepted/$2 
        else
            npx mastodon-cli fetch --older $LAST_ID --url $1 --account $2 --limit 50 --inbox ./accepted/$2 
        fi

        # Count
        COUNT=$(ls ./accepted/$2/*.jsonld | wc -l)

        if [ $COUNT -ge $MAX_COUNT_PER_ACCOUNT ]; then
            LEFT=$(($COUNT - $MAX_COUNT_PER_ACCOUNT))
            if [ $LEFT -gt 0 ]; then
                ls ./accepted/$2/*.jsonld | tail -$LEFT | xargs -n 1 rm
            fi
            break
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

    rm ./accepted/$2/*.meta
}

CMDLINE_MAX=$1
MAX_COUNT_PER_ACCOUNT=${CMDLINE_MAX:-$DEFAULT_MAX_COUNT_PER_ACCOUNT}

while IFS= read -r line || [[ -n "$line" ]]; do
    [[ "$line" =~ ^# ]] && continue
    URL=${line%;*}
    ACCOUNT=${line##*;}
    echo "${ACCOUNT}@${URL}..."
    if [ ! -d ./accepted/$ACCOUNT ]; then
        mkdir ./accepted/$ACCOUNT
    fi
    fetch $URL $ACCOUNT    
done < ${ACCOUNTS_FILE}