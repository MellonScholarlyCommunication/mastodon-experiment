#!/bin/bash

echo "Number of processed toots URLs:"

yarn -s event-admin list -qp "generator.id=https://www.npmjs.com/package/mastodon-cli" | wc -l

echo "Number of failed toots URLs:"

yarn -s event-admin list -qp "type=Reject" | wc -l

echo "Failed toot URLs:"

yarn -s event-admin export -qp "type=Reject" | jq ".data.object.object.id"