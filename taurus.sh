#!/bin/bash
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")
echo "Please provide session description (a-z, A-Z, - and _ characters accepted):"
read SESSIONDESCRIPTION
echo Please provide the config file to run:
read CONFIGFILE

mkdir -p results/$SESSIONDESCRIPTION/$TIMESTAMP/artifacts
mkdir -p results/$SESSIONDESCRIPTION/$TIMESTAMP/tests

cp -r tests/* results/$SESSIONDESCRIPTION/$TIMESTAMP/tests

docker run \
    -i \
    --rm \
    --net="host" \
    -v $(pwd)/results/$SESSIONDESCRIPTION/$TIMESTAMP/tests:/bzt-configs \
    -v $(pwd)/results/$SESSIONDESCRIPTION/$TIMESTAMP/artifacts:/tmp/artifacts \
    -v $(pwd)/results/$SESSIONDESCRIPTION/$TIMESTAMP:/tmp/results \
    blazemeter/taurus $CONFIGFILE
