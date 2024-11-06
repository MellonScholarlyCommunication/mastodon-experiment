#!/bin/bash

echo "[Number of processed toots URLs]"
echo

npx eventlog-server list -qp "generator.id=https://www.npmjs.com/package/mastodon-cli" | wc -l

echo "[Number of failed toots URLs]"
echo

npx eventlog-server list -qp "type=Reject" | wc -l

echo "[Failed toot URLs + reason]"
echo

npx eventlog-server export -qp "type=Reject" | jq -r '.data.object.object.id + " => " + .data.summary'

echo "[Testing failed toots]"
echo

npx eventlog-server export -qp "type=Reject" | jq -r '.data.object.object.id' | xargs -n 1 ./bin/link_test.js