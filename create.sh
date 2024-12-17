#!/bin/bash

############################### Functions ##############################

function usage {
   echo "Usage: $0 -v -h -D"
   echo "   -v: enable tracing of calls"
   echo "   -D: enable command echo"
   echo "   -h: print this message and exit"
   exit 1
}

function create_selection {
   local selected="0"
   local selections=("page" "sidebar" "subbar" "post")

   while [ ! -z "$selected" ]
   do
      # Select what to create
      select_from_array selections selected
      trace selected: ${selected}
      case "${selected}" in
         "page")
            create_page
            ;;
         "sidebar")
            create_sidebar
            ;;
         "subbar")
            create_subbar
            ;;
         "post")
            create_post
            ;;
         *)
            break ;;
      esac
   done
}

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

function cleanup {
   if [ ! -z "${tmpfile}" ] && [ -f ${tmpfile} ]
   then
      echo deleting ${tmpfile}
      rm ${tmpfile}
   fi
   exit 1
}

function create_subbar {
   # Create tempfile
   tmpfile=$(mktemp)

   echo "subbar:" > ${tmpfile}

   debug=true

   entries=("subbar" "entry" "submenu")
   entry=("url" "ext-url")

   trace entries=${entries[@]}
   trace entry=${entry[@]}

   echo "  entries:" >> ${tmpfile}

   add_selection "    "

   # Enter subbar file name
   get_line_input fname "Enter subbar file name" true

   cat -n ${tmpfile}

   is_yes ans "Save defined subbar above"

   if [ ${ans} == true ]
   then

      dest=${directory}/_data/sidebars/subbars/${fname}.yml

      trace dest=${dest}

      echo Creating subbar file ${fname}.yml in the subbars data directory

      # Move temporary file to the subbar data directory
      mv ${tmpfile} ${dest}

      echo Completed creation of subbar file ${fname}.yml

      # Add newly created subbar to the subbars array
      subbars+=("${fname}")

   else

      rm ${tmpfile}

   fi
}

function create_sidebar {
   # Create tempfile
   tmpfile=$(mktemp)

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

      # Move the temporary file to its final sidebar destination
      mv ${tmpfile} ${dest}

      echo Completed generating of sidebar file ${fname}.yml

      # Add newly created sidebar to the sidebars array
      sidebars+=("${fname}")

   else

      rm ${tmpfile}

   fi
}

function create_post {
   # Enter title of the post.
   get_line_input title "Enter post title" true
   echo

   # Enter subtitle of the post.
   get_line_input subtitle "Enter post subtitle" true
   echo

   # Enter author of the post.
   get_line_input author "Enter post Author" true "Claudio Corsi"
   echo

   # Enter post tags.
   get_array_input tags "Enter post tag{s}" true
   echo

   # Enter post categories
   get_array_input categories "Enter post associated categories" true
   echo

   # Enable debug.
   is_yes enable "Do you want to enable debugging"
   trace Enable debug=${enable}
   echo

   # Enable debug.
   is_yes published "Do you want to publish your post"
   trace Enable publish=${published}
   echo

   # Enter initial post text
   get_array_input text "Enter initial post text" true
   echo

   # Enter relative path name of the creating file
   get_line_input filename "Enter post file name without date prefix [YYYY-MM-DD-]" true
   echo

   # Determine if the _post directory exists
   if [ ! -d "${directory}/_post" ]
   then
       mkdir -p "${directory}/_post"
   fi

   fullname=${directory}/_posts/`date +"%Y-%m-%d"`-${filename}.md

   echo "Creating file ${fullname}"

   echo --- > ${fullname}
   echo layout: post >> ${fullname}
   echo title: ${title} >> ${fullname}
   if [ ! -z "${subtitle}" ]
   then
      echo subtitle: ${subtitle} >> ${fullname}
   fi
   if [ ! -z "author" ]
   then
      echo author: ${author} >> ${fullname}
   fi
   echo date: `date +"%Y-%m-%d %T %z"` >> ${fullname}
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
   if [ ${#categories[*]} -gt 0 ]
   then
      echo -n categories: [ ${categories[0]} >> ${fullname}
      typeset -i idx=1 len=${#categories[@]}
      while [ $idx -lt $len ]
      do
         echo -n , ${categories[$idx]} >> ${fullname}
         idx+=1
      done
      echo " ]" >> ${fullname}
   fi
   echo debug: ${enable} >> ${fullname}
   echo published: ${published} >> ${fullname}
   if [ ! -z "${sidebar}" ]
   then
      echo sidebar: ${sidebar} >> ${fullname}
   fi
   echo --- >> ${fullname}
   echo >> ${fullname}
   if [ "${#text[@]}" -gt 0 ]
   then
      for line in "${text[@]}"
      do
         echo ${line} >> ${fullname}
      done
   else
      if [ ! -z "${subtitle}" ]
      then
         echo Landing post for ${title} ${subtitle} >> ${fullname}
      else
         echo Landing post for ${title} >> ${fullname}
      fi
   fi
   echo >> ${fullname}

   echo "Created front matter for file ${fullname}"
}

function create_page {
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

   # Enter initial page text
   get_array_input text "Enter initial page text" true
   echo

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
   if [ "${#text[@]}" -gt 0 ]
   then
      for line in "${text[@]}"
      do
         echo ${line} >> ${fullname}
      done
   else
      if [ ! -z "${subtitle}" ]
      then
         echo Landing page for ${title} ${subtitle} >> ${fullname}
      else
         echo Landing page for ${title} >> ${fullname}
      fi
   fi
   echo >> ${fullname}

   echo "Created front matter for file ${fullname}"
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

echo Gathering sidebars
# Get sidebar entries
get_entries sidebars "ls ${directory}/_data/sidebars/*.yml | sed s/\.yml//" "basename" true
trace Found sidebars=${sidebars[@]}
echo Done gathering sidebars

echo Gathering subbars
# Get subbar entries
get_entries subbars "ls ${directory}/_data/sidebars/subbars/*.yml | sed s/\.yml//" "basename" true
trace Found subbars=${subbars[@]}
echo Done gathering subbars

# Add trap to insure that the temporary file is deleted if not used
trap cleanup INT SIGINT

while getopts "Dvh" o; do
   case "${o}" in
      v) debug=true
	      ;;
      D) set -x
         ;;
      h) usage
   esac
done

create_selection

