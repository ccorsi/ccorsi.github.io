#!/bin/bash

#####################################################################

# Get the fully qualified path name to the commonrc file
rcfile=`dirname $0`/commonrc

if [ -f "$rcfile" ];
then
   # source in the commonrc file to include common functions and variables
   source $rcfile
fi

# Set the debug variable to false for now.
debug=false

get_script_name name $0
get_script_dir directory $0

trace Calling $name located in $directory

get_entries sidebars "ls ${directory}/_data/sidebars/*.yml | sed s/\.yml//" "basename" true
trace Found sidebars=${sidebars[@]}

# Enter title of the page.
get_line_input title "Enter page title" true
echo

# Enter subtitle of the page.
get_line_input subtitle "Enter page subtitle" true
echo

# Enter author of the page.
get_line_input author "Enter page Author" true "Claudio Corsi"
echo

# Enter page tags.
get_array_input tags "Enter page tag{s}" true
echo

# Enter permalink
get_line_input permalink "Enter permalink" true
echo

# Enable debug.
is_yes enable "Do you want to enable debugging"
trace Enable debug=${enable}
echo

# Select the sidebar
select_from_array sidebars sidebar
trace Selected sidebar=${sidebar}
echo
# result=$(IFS=, ; echo "${sidebars[*]}")
# echo result=[$result]

# Enter relative path name of the creating file
get_line_input filename "Enter relative path of file name" true
echo

dir=`dirname ${filename}`
fname=`basename ${filename}`

if [ ! -z "${dir}" ]
then
   fullname=${directory}/${dir}/${fname}
   if [ ! -d "${directory}/${dir}" ]
   then
      mkdir -p ${directory}/${dir}
   fi
else
   fullname=${directory}/${fname}
fi

echo "Creating file ${fullname}"

echo --- > ${fullname}
echo title: ${title} >> ${fullname}
if [ ! -z "${subtitle}" ]
then
   echo subtitle: ${subtitle} >> ${fullname}
fi
if [ ! -z "author" ]
then
   echo author: ${author} >> ${fullname}
fi
if [ ${#tags[*]} -gt 0 ]
then
   echo -n tags: [ ${tags[0]} >> ${fullname}
   typeset -i idx=1 len=${#tags[@]}
   while [ $idx -lt $len ]
   do
      echo -n , ${tags[$idx]} >> ${fullname}
      idx+=1
   done
   echo " ]" >> ${fullname}
fi
echo permalink: ${permalink} >> ${fullname}
echo debug: ${enable} >> ${fullname}
if [ ! -z "${sidebar}" ]
then
   echo sidebar: ${sidebar} >> ${fullname}
fi
echo --- >> ${fullname}
echo >> ${fullname}
if [ ! -z "${subtitle}" ]
then
   echo Landing page for ${title} ${subtitle} >> ${fullname}
else
   echo Landing page for ${title} >> ${fullname}
fi
echo >> ${fullname}

echo "Created front matter for file ${fullname}"

