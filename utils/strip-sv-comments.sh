
#grep -v "//" $1
sed -e 's/\/\/.*//g' $1
