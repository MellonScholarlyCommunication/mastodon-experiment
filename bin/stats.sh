#!/bin/bash

echo "[Processing time]"

FIRST_NOTIFICATION=$(npx eventlog-server list --limit 1)
LAST_NOTIFICATION=$(npx eventlog-server list | tail -1)

DATE1=$(npx eventlog-server get ${FIRST_NOTIFICATION} | jq -r ".published")
DATE2=$(npx eventlog-server get ${LAST_NOTIFICATION} | jq -r ".published")

echo "First notification: ${DATE1}"
echo "Last notification: ${DATE2}"  

DATE1_S=$(date -d ${DATE1} +%s)
DATE2_S=$(date -d ${DATE2} +%s)
DIFF=$(((DATE2_S - DATE1_S)/3600))
echo "Difference: ${DIFF}"

echo
echo "[Number of processed toots]"

npx eventlog-server list -qp "generator.id=https://www.npmjs.com/package/mastodon-cli" | wc -l

echo
echo "[Number of processed toot URLs]"

TMP=$(mktemp)

npx eventlog-server export -qp "generator.id=https://www.npmjs.com/package/mastodon-cli" | jq -r ".data.object.url | select (. != null) | .[].href" > ${TMP}

cat ${TMP} | wc -l

URL_UNQ=$(cat ${TMP} | sort -u | wc -l)
echo "${URL_UNQ} (unique)"

URL_PDF=$(cat ${TMP} | grep "\.pdf$" | wc -l)
echo "${URL_PDF} (pdf urls, zotero can't process that)"

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