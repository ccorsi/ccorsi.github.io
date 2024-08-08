#!/bin/bash -x

# for pair in `cat pairs`
# do
   # left=`echo $pair | cut -f 1 -d " "`
   # right=`echo $pair | cut -f 2 -d " "`
   # echo left = $left and right = $right
   # # set -- $pair
   # # echo $1 implies $2
# done
 
# for line in `cat pairs`
# do
	# echo line = $line
# done
 
while read line
do
   echo line = $line
   set -- $line
   if [ -z "$2" ]; then
      echo single parameter $1
   else
      echo $1 implies $2
   fi
done < pairs

function build_site {
   echo building site $1
}

build_site "foo"
build_site "bar"

