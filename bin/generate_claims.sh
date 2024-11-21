#!/bin/bash

cd ../rdf-generator

echo "Dropping old database ..."
yarn real-clean

echo "Importing the events database..."
yarn database:import

echo "Exporting the claims as JSON and RDF..."
./export.sh

echo "Running some statistics..."
./stats.sh