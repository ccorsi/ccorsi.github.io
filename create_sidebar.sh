#!/bin/bash

# This script can be used to create a sidebar so that one doesn't need
# to remember how to create such a sidebar and just focus on what will
# be contained within the defining sidebar.

# function call {
   # $@
# }

# function called {
   # echo Called Me with parameters $@
# }

# call called
# call called Hello

############################### Functions ##############################

function add_selection {
   check "add_selection" 1 $#

   local prefix="$1"
   local selected="0"
   local subbar title uri link

   while [ ! -z "$selected" ]
   do
      # Enter sidebar enteries
      select_from_array entries selected
      trace entries selected: ${selected}
      case "${selected}" in
         "subbar")
            select_from_array subbars subbar true
            trace subbar selected: ${subbar}
	    if [ ! -z "subbar" ]
            then
	      echo "${prefix}- subbar: ${subbar}" >> ${tmpfile}
            fi
            ;;
         "entry")
            get_line_input title "Enter entry title" true
            trace title selected: ${title}
	    if [ ! -z "title" ]
            then
	      echo "${prefix}- entry: ${title}" >> ${tmpfile}
            fi
            select_from_array entry uri
            trace uri selected: ${uri}
	    if [ ! -z "uri" ]
            then
              get_line_input link "Enter entry link" true
              trace link selected: ${link}
	      echo "${prefix}  ${uri}: ${link}" >> ${tmpfile}
            fi
            ;;
         "submenu")
            get_line_input title "Enter submenu title" true
	    echo "${prefix}- title: ${title}" >> ${tmpfile}
	    echo "${prefix}  submenu:" >> ${tmpfile}
            local append="    ${prefix}"
	    add_selection "$append"
            ;;
         *)
            break ;;
      esac
   done
}

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

# Get sidebar entries
get_entries sidebars "ls ${directory}/_data/sidebars/*.yml | sed s/\.yml//" "basename" true
trace Found sidebars=${sidebars[@]}

# Get subbar entries
get_entries subbars "ls ${directory}/_data/sidebars/subbars/*.yml | sed s/\.yml//" "basename" true
trace Found subbars=${subbars[@]}

# Create tempfile
tmpfile=$(mktemp)

function cleanup {
   if [ -f ${tmpfile} ]
   then
      echo deleting ${tmpfile}
      rm ${tmpfile}
   fi
   exit 1
}

trap cleanup INT SIGINT

echo "sidebar:" > ${tmpfile}

# Entry sidebar title
get_line_input title "Enter sidebar title" true
echo "  title: ${title}" >> ${tmpfile}

entries=("subbar" "entry" "submenu")
entry=("url" "ext-url")

trace entries=${entries[@]}
trace entry=${entry[@]}

echo "  entries:" >> ${tmpfile}

# Add sidebar entries
add_selection "    "

# Enter sidebar file name
get_line_input fname "Enter sidebar file name" true

cat -n ${tmpfile}

is_yes ans "Save defined sidebar above"

if [ ${ans} == true ]
then

   dest=${directory}/_data/sidebars/${fname}.yml

   trace dest=${dest}

   echo Generating sidebar file ${fname}.yml in sidebars data directory

   # cat -n ${tmpfile} # mv ${tmpfile} ${fname}
   mv ${tmpfile} ${dest}

   echo Completed generating of sidebar file ${fname}.yml

else

   rm ${tmpfile}

fi

