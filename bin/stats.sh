#!/bin/bash

echo "[Number of processed toots]"

npx eventlog-server list -qp "generator.id=https://www.npmjs.com/package/mastodon-cli" | wc -l

echo "[Number of processed toot URLs]"

TMP=$(mktemp)

npx eventlog-server export -qp "generator.id=https://www.npmjs.com/package/mastodon-cli" | jq -r ".data.object.url | select (. != null) | .[].href" > ${TMP}

cat ${TMP} | wc -l

URL_UNQ=$(cat ${TMP} | sort -u | wc -l)
echo "${URL_UNQ} (unique)"

rm ${TMP}

echo
echo "[Number of successfull toot URLs]"

npx eventlog-server export -qp "actor.id=https://wiki.mycontributions.info/profile/card#me" | jq -r ".data | select(.type == \"Announce\") | .object.url" | wc -l

echo
echo "[Number of failed toots URLs]"

npx eventlog-server list -qp "type=Reject" | wc -l

echo
echo "[Failed toot URLs + reason]"

npx eventlog-server export -qp "type=Reject" | jq -r '.data.object.object.id + " => " + .data.summary'