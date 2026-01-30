#!/usr/bin/env bash

# set path for local perl environment
export PERLBREW_ROOT=/opt/perl5
source ${PERLBREW_ROOT}/etc/bashrc 

set -euo pipefail

BASE_DIR="$HOME/lod4leaflet"
DICT_DIR="$BASE_DIR/dictionary"
FIX_DIR="$BASE_DIR/fix"
INPUT_FILE="$HOME/bms_beacon/dmp/beacon_tggib.txt"

#select gndid from beacon
grep -oP '^[\d-]+\|\|[\dX]+$' $INPUT_FILE | sed 's/||/,/g' > $DICT_DIR/beacon_dictionary.csv
grep -oP '^\d.+(?=\|\|)' < $INPUT_FILE > $DICT_DIR/gndid.csv
sed -i '1i gndid' $DICT_DIR/gndid.csv

#create gndid.json
catmandu convert CSV to JSON --line_delimited 1 < $DICT_DIR/gndid.csv > $DICT_DIR/gndid.json

#detect qid
cat $DICT_DIR/gndid.json | catmandu convert getJSON --url 'https://hub.culturegraph.org/entityfacts/{gndid}' --fix $FIX_DIR/qid.fix to CSV --fields 'gndid,qid' > $DICT_DIR/qid_dictionary.csv 

#detect coordinates at wikidata
catmandu convert CSV < $DICT_DIR/qid_dictionary.csv to CSV --fields 'qid' --header 0 | catmandu convert Wikidata --fix $FIX_DIR/wikidata.fix to CSV --fields qid,coords > $DICT_DIR/coords.csv 

#create dictionaries
catmandu convert CSV --fields qid,gndid to CSV --header 0 < $DICT_DIR/qid_dictionary.csv > $DICT_DIR/lookup.csv
catmandu convert CSV --fix $FIX_DIR/lookup.fix to CSV --fields gndid,coords < $DICT_DIR/coords.csv > $DICT_DIR/gndid_coords_dictionary.csv

#select efacts data, merge with coords from wikidata an create javascript including html
cat $DICT_DIR/gndid.json | catmandu convert getJSON --url 'https://hub.culturegraph.org/entityfacts/{gndid}' --fix $FIX_DIR/lod4leaflet.fix to Text > $HOME/lod4leaflet/lod4leaflet.js
sed -i '1i var addressPoints = [' $HOME/lod4leaflet/lod4leaflet.js
sed -i '$a ];' $HOME/lod4leaflet/lod4leaflet.js

echo "Processing successfully completed: $(date)"
echo "---------------------------------------------------"
