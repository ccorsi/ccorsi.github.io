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
   case "$1" in
      page)
         usage_page
         ;;
      post)
         usage_post
         ;;
      sidebar)
         usage_sidebar
         ;;
      subbar)
         usage_subbar
         ;;
      update)
         usage_update
         ;;
   esac
   
   echo "Usage: $0 -v -h -D -H [page|sidebar|subbar|post|update]"
   echo "   -v: enable tracing of calls"
   echo "   -D: enable command echo"
   echo "   -h: print this message and exit"
   echo "   -H [page|sidebar|subbar|post|update]: prints detailed help and exits"
   exit 1
}

# This text will provide a common overview of the different detailed help so
# that the user can then understand the common reason for this type of help
# within this script
HEADER=$(cat << 'EOF'
This script provides several different ways of creating and updating the current
type of web pages and their menus.

The objective is to provide a common means of producing web pages, including posts,
for this web site such that the design is consistent throughout the site.

The following describes the specific detailed help associated to the requested feature.

EOF
)

function usage_page {
   OUTPUT=$(cat << EOF
$HEADER

This selection is used to create web pages that are not posts.  Those type of pages
will require that you select that post option of the list of options.

The difference between creating a post and page is that the page will allow you to
associate a embedded menu providing better movement and separations between web pages.

The creation of a new web page will require that one has already created an associated
sidebar that contains the different references associated with the creating web page.

While the list of options will become clear as you are asked to input.  There is a
few notes that should be mentioned.

The permenent link of the generated web page should be started with a '/' character
and should end with '/' for pages that will generate an index file.  While web pages
that will not generate an index file that would require that you include the resulting
generated file name.  For example, a indexed generated file for a permalink:

   /topfolder/subfolder/

note that you need to include the '/' as a prefix and suffix.

As for a non-indexed file example for a permalink:

   /topfolder/subfolder/filename.html

again you need to prefix the name with the '/' character.

The other note is that the generated filename for the file that will contain
the text used to generate the web page.  You should include the required
suffix so that Jekyll will be able to correctly generate the web page. For
example:

   topdirectory/subdirectory/filename.md

The above will then allow Jekyll to correctly parse the input used to generate
the web page.

EOF
)

   echo "$OUTPUT" | less
}

function usage_sidebar {
   OUTPUT=$(cat << EOF
$HEADER

This selection is used to create a sidebar to used by a page.  This sidebar is a in page
menu that the user can use to navigate through the current page.  The reason behind creating
a sidebar is that the current general navigation bar is limited to the number of levels deep
that is can be defined.  The current navigation bar on the top of each page can only go one
level deep.  Thus, the use of sidebars allow us the ability to produce links to multiple
pages within a single topic/selection.

The creation of a sidebar should be done after you've created all the referencing subbars
associated with the sidebar.  Granted, this tool does provide the ability to append to a
selected sidebar after it has been created.  It is better that you initially organize the
way that you would like to navigate your sidebar.

The creation of a sidebar should reference one or more of the following types of subbars.

   - a "HOME" subbar
   - a "INDIVIDUAL" subbar

The above types of subbar provide logic that makes it easier to create and use the different
subbars that are used by a sidebar.  These types of subbars are further explained within the
subbar help sectio of this script.  We are then going to continue describing how a sidebar
is created.

A sidebar is created using the "HOME" subbar to reference a different page within the current
topic/section.  This subbar is usually defined as "<section_name>[-<subsection_name>]*-home",
where the <section_name> and <subsection_name>'s coorespond to the names of the levels of the
sidebar topic/selection.

While the use of the "INDIVIDUAL" subbar references are used to link the different topic specific
pages that is related to the current topic/section.  This can be anything from in host pages or
external links associated with the current topic/section.

EOF
)

   echo "$OUTPUT" | less
}

function usage_subbar {
   OUTPUT=$(cat << EOF
$HEADER

This selection is used to create a subbar. Subbars are associated with a sidebar and offer specific
links for navigation within the current topic/section.  These navigations can be anything from
going to a top-level page to pointing to a sub-topic/sub-section of the current topic/section.
Thus, different subbars can be created depending on what they are used for.  While there is a
flexible feature of creating and using a subbar.  There is a recommended design and usage of
subbars.  These will be described in the next section.

There are two different types of subbars that should be created.

   - HOME
   - INDIVIDUAL

The above types will be able to seperate how each will be used within the context of a sidebar.
The HOME subbar will contain a reference to a given page within the web site.  While an
INDIVIDUAL subbar will contain references to links relevant to the current topic/section.  This
will then be able to use the HOME subbar within a sidebar that references a different topic/section
than the current page topic/section.  While the INDIVIDUAL subbar is used to reference all of the
different topic/sections associated with the current topic/section.

Let us describe the different options associated to creating a subbar.  A subbar can reference one
or more entries and each entry can define one or more types.   Let us then expand on what each ones
contain as options.

The subbars list of entries can be one of the following:

   - subbar
   - entry
   - submenu

The subbar entry is just being able to reference another defined subbar that will be references within
this currently defining subbar. 

The entry options can then define the following options:

   - url
   - ext-url

The url option is just a local reference to the site pages.  While the ext-url is a link that is located
outside of the web site.  This will open the page within a new tab allowing you to be able to come back
to the site current page.

The url option will define a url path relative to the root url path of the current site.  For instance,
if we have the following path:

   - /home/foo/bar/

The above will then open current site web page at http{s}://home/foo/bar/.  Note that in the example
above that a '/' was added at the end.  This is required whenever you want to open the define index
web file that is located within the /home/foo/bar directory of the web site.  If you want to reference
a web page that is not the default.  You need to include the fully qualified web page like:

   - /home/foo/bar/list.html

This will then be referencing the specific local web page.

The ext-url option will define an external link that will be opened within its own browser tab.  This
will then allow you to be able to move back and fourth between the current web site and the external
web site.

Lastly, the submenu option just allows you to create a section that will contain similar topic/selection
within the submenu.  Upon creating the submenu, you can then add one or more of the entry, subbar or
submenu.

EOF
)

   echo "$OUTPUT" | less
}

function usage_post { 
   OUTPUT=$(cat << EOF
$HEADER

This selection is used to create a post page that is different from a regular web page using the
page option.  There are differences between creating a post and page.  The main difference is that
a post will request other types of information that will be attached to the creating post.  This
information is specific to a regular web site post that is not associated with a regular web page.

The creation of a post will then prompt you for different information associated with the newly
creating post.  While some of them are obvious and these will not be mentioned here.  Thus, we will
only discuss the ones that aren't as obvious options.

You will be asked to associate a list of tags to your post.  These tags are used as a search mechanism
for your posts.  It allows visitors the ability to find specific topics that they would be interested
in reading.

The next option are categories that you would enter for the creating post.  Categories are used to
associate a general topic instead of specific identities like tags.  This allows the site to be
organized to reflect the seperation of the post themselves.  While creating different categories is
a great idea.  There is the caveat that you should keep the number of categories under ten for better
site organizations.  While this option can be defined here.  It isn't limited to defining them here.
One can create seperate categories by just using the directory level definitions.  Thus, you can
create all tech topics within the tech directory of the posts directory which defines the "tech"
category.

The next option is to enable debugging of your post generation.  This is only useful when you are
trying to understand why a particular page generation is not what you are looking for.  It can be
useful but then it was added such that it might be useful in the future.

The next option is weather this post should be published or if it is still being developed.  This
simplifies the need to complete your post as soon as possible.  This then will allow you the space
and time to properly develop the post without having to keep the copy locally.

The final step offer you an oppurtunity to add some initial content to your post when it is being
created.  While this section doesn't offer the flexibility of an editor.  It nonetheless provides
some beginning to your post.

The last step requires that you associate a filename to this post.  The name of the file should
also include the .md prefix for it to be properly processed using Jekyll.  The name of the file
post doesn't require it to be preceeded by '/' since these files will be created within the posts
directory.

EOF
)

   echo "$OUTPUT" | less
}

function usage_update {
   OUTPUT=$(cat << EOF
$HEADER

This selection is used whenever you need to make changes to the currently created sidebar and subbar.
The current implementation of this feature is that you can only add to the current sidebar and subbar.
If you want to replace any of the entries, you would need to edit these implementations directly.
Hopefully, in the future we can then update the current set of entries instead of only be able to add
to the current entries for the selected sidebar and/or subbar.

EOF
)

   echo "$OUTPUT" | less
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

   # TODO: we need to be able to determine if the filename contains category definitions
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

# Process the command line arguments
while getopts "H:hDv" o; do
   case "${o}" in
      v) debug=true
         ;;
      D) set -x
         ;;
      h) usage
         ;;
      H) usage $OPTARG
         ;;
      *) usage
         ;;
   esac
done

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

create_selection
