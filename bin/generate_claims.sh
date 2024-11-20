#!/bin/bash

( cd ../rdf-generator & yarn database:import )
( cd ../rdf-generator & ./export )

echo "You can now run the stats.sh in ../rdf-generator"