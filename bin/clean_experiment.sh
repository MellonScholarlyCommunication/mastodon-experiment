#!/bin/bash

echo "Cleaning accepted..."
yarn real-clean

echo "Cleaning cache..."
npx eventlog-server remove-all

echo "Cleaning wiki..."
./bin/clean_wiki.sh