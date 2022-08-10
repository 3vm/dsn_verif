#!/bin/bash
find . -name 'README.md' | xargs  \
sed -i -e 's/^.*patreon.*//g' \
       -e 's/^.*become a patron.*/If you would like designs, models like these contact@valsid.in/g' 
