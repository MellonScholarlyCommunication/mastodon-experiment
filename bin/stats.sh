#!/bin/bash

echo "[Number of processed toots URLs]"

npx eventlog-server list -qp "generator.id=https://www.npmjs.com/package/mastodon-cli" | wc -l

echo
echo "[Number of failed toots URLs]"

npx eventlog-server list -qp "type=Reject" | wc -l

echo
echo "[Failed toot URLs + reason]"

npx eventlog-server export -qp "type=Reject" | jq -r '.data.object.object.id + " => " + .data.summary'