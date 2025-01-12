#!/bin/bash

########################################################################
# This script is used to create the different artifacts that are part
# of this static web site.  This script currently contains the ability
# to create a new page, post, sidebar and subbar.  This functionality
# removes the need to look through prior creations of these types of
# artifacts and just focus on what you are trying to accomplish.
#
# While the above implementation provides the ability to automate the
# creation of those artifacts.  There was a need to be able to update
# the existing sidebars and subbars.  Thus, the addition of updating
# the current content of the sidebars and subbars have been added to
# this script.
#
# While the above describes the current work that makes it easier to
# maintain this web site.  There is at least one other addition that
# would be helpful.  This is the ability to not only add to a sidebar
# or subbar but it is the ability to actually remove/replace current
# entries within these sidebars and subbars.  While this work is not
# necessary it is something that can be useful in the future.
########################################################################

############################### Functions ##############################

function usage {
   echo "Usage: $0 -v -h -D"
   echo "   -v: enable tracing of calls"
   echo "   -D: enable command echo"
   echo "   -h: print this message and exit"
   exit 1
}

########################################################################
# This function is used to select the different create and update
# actions of this script.  This is the top level call where everything
# is handled.
#
# This method allows one to be able to process one or more action
# without having to call this script multiple times.
########################################################################
function create_selection {
   local selected="0"
   local selections=("page" "sidebar" "subbar" "post" "update")

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
         "update")
            update_data
            ;;
         *)
            break ;;
      esac
   done
}

########################################################################
# This method is used to determine if a sidebar or subbar will be
# updated.  It will then call the required update calls.  While this
# is not really required.  In the future, it can be updated to include
# other types of updates.
########################################################################
function update_data {
   local selected="0"
   local selections=("sidebar" "subbar")

   while [ ! -z "$selected" ]
   do
      # Select what to create
      select_from_array selections selected
      trace selected update: ${selected}
      case "${selected}" in
         "sidebar")
            update_sidebar
            ;;
         "subbar")
            update_subbar
            ;;
         *)
            break ;;
      esac
   done
}

########################################################################
# This method will take the current set of entries within a given sidebar
# and allow you to be able to append new entries to the current set of
# entries.  While the current implementation doesn't provide the ability
# to replace/remove any of the current entries.  That objective will
# require a more extensive rewrite of the current method.
########################################################################
function update_sidebar {

   # Select the sidebar
   select_from_array sidebars sidebar
   trace Selected sidebar=${sidebar}
   echo

   if [ ! -z "${sidebar}" ]
   then
      # Read in the selected sidebar
      local fname="${directory}/_data/sidebars/${sidebar}.yml"

      if [ -f ${fname} ]
      then
         trace sidebar=${sidebar} exists at ${fname}

         # create a temporary file
         tmpfile=$(mktemp)

         echo "Updating sidebar file with current content:"

         # copy contents into temporary file
         cat ${fname} | tee ${tmpfile}
         echo

         # setup required entries for add_selection function call
         entries=("subbar" "entry" "submenu")
         entry=("url" "ext-url")

         # add other selections
         add_selection "    "

         cat -n ${tmpfile}

         is_yes ans "Save updated sidebar above"

         if [ ${ans} == true ]
         then

            trace dest=${fname}

            echo Updating sidebar file ${sidebar}.yml in sidebars data directory

            # Replace current sidebar file with updated temporary file
            mv ${tmpfile} ${fname}

            echo Completed updating of sidebar file ${sidebar}.yml

         else

            rm ${tmpfile}

         fi

      else
         echo "sidebar=${sidebar} doesn't exist at ${fname}"
      fi
   else
      echo "no sidebar was selected"
   fi
}

########################################################################
# This method will take the current set of entries within a given subbar
# and allow you to be able to append new entries to the current set of
# entries.  While the current implementation doesn't provide the ability
# to replace/remove any of the current entries.  That objective will
# require a more extensive rewrite of the current method.
########################################################################
function update_subbar {

   # Select the subbar
   select_from_array subbars subbar
   trace Selected subbar=${subbar}
   echo

   if [ ! -z "${subbar}" ]
   then
      # Read in the selected sidebar
      local fname="${directory}/_data/sidebars/subbars/${subbar}.yml"

      if [ -f ${fname} ]
      then
         trace subbar=${subbar} exists at ${fname}

         # create a temporary file
         tmpfile=$(mktemp)

         echo "Updating subbar file with current content:"

         # copy contents into temporary file
         cat ${fname} | tee ${tmpfile}
         echo

         # setup required entries for add_selection function call
         entries=("subbar" "entry" "submenu")
         entry=("url" "ext-url")

         # add other selections
         add_selection "    "

         cat -n ${tmpfile}

         is_yes ans "Save updated subbar above"

         if [ ${ans} == true ]
         then

            trace dest=${fname}

            echo Updating subbar file ${subbar}.yml in sidebars data directory

            # Replace current subbar file with updated temporary file
            mv ${tmpfile} ${fname}

            echo Completed updating of subbar file ${subbar}.yml

         else

            rm ${tmpfile}

         fi

      else
         trace "subbar=${subbar} doesn't exist at ${fname}"
      fi
   else
      trace "no subbar was selected"
   fi
}

########################################################################
# This method is used to add a selection for a sidebar or subbar.  The
# information will be appended to the current tmpfile.  This method will
# use the passed prefix string for the generated output.  The prefix is
# used to properly format the current tmpfile.
########################################################################
function add_selection {
   # Check that the add_selection is passed a non-empty prefix string
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

########################################################################
# This method is called within the trap functionality whenever one or
# more of the signals hava been generated within this script.  This
# method will just delete the currently created tmpfile such that it
# doesn't stick around after exiting this script in an unexpected way.
########################################################################
function cleanup {
   if [ ! -z "${tmpfile}" ] && [ -f ${tmpfile} ]
   then
      echo deleting ${tmpfile}
      rm ${tmpfile}
   fi
   exit 1
}

########################################################################
# This method is used to create a new subbar by asking you questions on
# what you want to include as part of the creating subbar.  You can also
# use the current set of subbars to add to the creating subbar.  Upon
# creating the new subbar, it will then be added to the current list of
# subbars such that you can then use it within the creation of new
# sidebars or subbars.
########################################################################
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

########################################################################
# This method will create a new sidebar by asking the caller questions
# on what they would like to be part of the newly creating sidebar.  It
# can use the current set of subbars.  The newly created sidebar will
# then be added to the current list of sidebars such that you can then
# include the newly created sidebar as part of the creation of a new
# page.
########################################################################
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

########################################################################
# This method will create a post page through the action of asking the
# caller questions about what they would like to see within a newly
# created web page.  It will then use the inputted information to
# generate the web page.
########################################################################
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

########################################################################
# This method will create a page through the action of asking the caller
# questions about what they would like to see within a newly created
# web page.  It will then use the inputted information to generate the
# web page.
########################################################################
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

   # Enter relative path name for the page
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

# Process the command line arguments
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

