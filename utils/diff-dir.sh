#!/bin/bash

for f in `ls $1/*`
  do echo $f ; tkdiff $f $2/ &
done
