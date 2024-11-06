#!/bin/bash

echo "Number of processed toots URLs:"

npx eventlog-server list -qp "generator.id=https://www.npmjs.com/package/mastodon-cli" | wc -l

echo "Number of failed toots URLs:"

npx eventlog-server list -qp "type=Reject" | wc -l

echo "Failed toot URLs:"

npx eventlog-server event-admin export -qp "type=Reject" | jq ".data.object.object.id"