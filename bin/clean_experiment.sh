#!/bin/bash

yarn real-clean

npx eventlog-server remove-all

./bin/clean_wiki.sh