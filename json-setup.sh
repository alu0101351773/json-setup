#! /bin/bash

function generate_module() {
filename=$1
recortada=$(echo $1 | sed -e 's/\..*$//' | tr -d '-')
cat << _EOF_
/**
 * @module $recortada Object containing country population data
 */

// TODO: $recortada
const {readFileSync} = require('fs');

const content = readFileSync('./json-data/$filename', 'utf-8');
const data = JSON.parse(content);

const $recortada = {};
for (const specificCountry of data) {
  $recortada[specificCountry.country] = specificCountry.population;
}

module.exports = {$recortada};
_EOF_
}

while [ "$1" != "" ]; do
  destination_file="src/modules/$(echo $1 | sed -e 's/\..*$//').js"
  generate_module $1 > $destination_file
  shift
done

