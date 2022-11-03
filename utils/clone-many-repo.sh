#!/usr/bin/tcsh

set repolist=$1

echo "List of repositories file $repolist"

foreach a ( `awk '{print $1}' $repolist` )
  echo "Now cloning $a"
  git clone https://github.com/freecores/$a
end

