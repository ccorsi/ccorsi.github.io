#!/bin/sh

#----------------------------------------
#
# Filename:    createdoc.sh
#
# Description: This script is used to create different types of
#       pages that will be used within the different web sites.
#
# Created by:  Claudio Corsi on July 06, 2024
#
# Copyright (c) 2024 Claudio Corsi. All rights reserved.
#
#----------------------------------------

############################### Variables ##############################

# Get the documentation root directory
docdir=`dirname $0`

# Get the fully qualified path name to the commonrc file
rcfile=${docdir}/../commonrc

########################################################################

############################### Functions ##############################

# This function is used for creating initial page type file that will be
# created within the pages subdirectory.  This function will offer the
# user the opportunity to enter what will be part of the frontmatter of
# the newly created page.
#
# ---
# title: <title>
# keywords: <keyword> [, <keyword> ]*
# [last_updated: <month> <day>, <year>]
# summary: <summary>
# sidebar: <sidebar>
# [tags: \[ <name> [, <name>]* \]
# [toc: false]
# permalink: <permalink>
# [simple_map: <true|false>]
# [map_name: <map_name>]
# [box_number: <[1-9][0-9]*>]
# folder: <folder>
# ---
#
# {% include links.html %}

function create_page {
    name=
    title=
    keywords=()
    summary=
    sidebar=
    tags=()
    toc=
    permalink=
    folder=
    extras=()
    ans=

    get_line_input name "Enter page file name without .html suffix: "
    get_line_input title "Enter page title: "
    get_line_input summary "Enter page summary: "
    get_line_input sidebar "Enter page sidebar: "
    is_yes toc "Is table of content require: "
    is_yes ans "Does page require a folder front matter entry: "
    if [[ $ans = true ]]
    then
        get_line_input folder "Enter folder name: "
        is_yes ans "Use permalink set to '${folder}_${name}.html': "
        if [[ $ans = false ]]
        then
            get_line_input permalink "Enter page permalink: "
        else
            permalink=${folder}_${name}.html
        fi
        fname="${docdir}/pages/${folder}/${permalink}"
    else
        is_yes ans "Use permalink set to '${name}.html': "
        if [[ $ans = false ]]
        then
            get_line_input permalink "Enter page permalink: "
        else
            permalink=${name}.html
        fi
        fname="${docdir}/pages/${permalink}"
    fi
    get_array_input tags "Enter each tag on a separate line for this page: "
    get_array_input keywords "Enter each keyword on a separate line for this page: "
    get_array_input extras "Enter each extra front matter key/value on a separate line separated by '=': "
    last_updated=`date +"%B%e, %Y"`

    echo -e "\n\n"
    echo "Front matter:"
    echo -e "\n\n---"
    frontmatter=`echo "title: ${title}\n"`
    if (( ${#keywords[@]} != 0))
    then
        words=""
        for keyword in "${keywords[@]}"
        do
            if [ ! -z "$words" ]
            then
                words+=", "
            fi
            words+=$keyword
        done
        frontmatter+=`echo "keywords: [ " $words " ]\n"`
    fi
    frontmatter+=`echo "published: false\n"`
    frontmatter+=`echo "last_updated: ${last_updated}\n"`
    frontmatter+=`echo "summary: $summary\n"`
    frontmatter+=`echo "sidebar: $sidebar\n"`
    if (( ${#tags[@]} != 0))
    then
        words=""
        for tag in "${tags[@]}"
        do
            if [ ! -z "$words" ]
            then
                words+=", "
            fi
            words+=$tag
        done
        frontmatter+=`echo "tags: [ " $words " ]\n"`
    fi
    if [[ $toc = false ]]
    then
        frontmatter+=`echo "toc: false\n"`
    fi
    frontmatter+=`echo "permalink: $permalink\n"`
    if [[ ! -z "$folder" ]]
    then
        frontmatter+=`echo "folder: $folder\n"`
    fi
    if (( ${#extras[@]} != 0))
    then
        for extra in "${extras[@]}"
        do
            IFS='=' read -ra pair <<< $extra
            frontmatter+=`echo "${pair[0]}: ${pair[1]}\n"`
        done
    fi
    echo "---"
    echo -n -e $frontmatter
    echo "---"
    is_yes ans "Create page ${fname} with the above front matter? "
    if [[ $ans = true ]]
    then
        echo Creating page $fname 
        mkdir -p `dirname $fname`
        echo "---" > $fname
        echo -n -e $frontmatter >> $fname
        echo -e "---\n{% include links.html %}" >> $fname
    fi
} # create_page

# This function is used for creating a tag that can be used for the different 
# pages that are being created.
function create_tag {
    tagname=
    title=
    sidebar=

    get_line_input tagname "Enter name of tag: "
    get_line_input title "Enter ${tagname} title: "
    get_line_input sidebar "Enter ${tagname} sidebar: "

    tag="---\n"
    tag+="title: \"${title}\"\n"
    tag+="tagName: ${tagname}\n"
    tag+="search: exclude\n"
    tag+="permalink: tag_${tagname}.html\n"
    tag+="sidebar: ${sidebar}\n"
    tag+="hide_sidebar: true\n"
    tag+="folder: tags\n"
    tag+="---\n\n"

    echo -e "\n\n$tag"
    ans=
    is_yes ans "Create tag ${tagname} with the above front matter? " 
    if [[ $ans = true ]]
    then
        tag+="{% include taglogic.html %}\n\n"
        tag+="{% include links.html %}"
        echo -e "${tag}" >"${docdir}/pages/tags/tag_${tagname}.html"
        echo "  - ${tagname}" >>${docdir}/_data/tags.yml
    fi

} # create_tag

# This function is used for creating initial port type file that will be
# created within the _posts subdirectory.  This function will offer the
# user the opportunity to enter what will be part of the frontmatter of
# a newly created post.
function create_post {
    title=
    name=
    permalink=
    summary=
    tags=()

    get_line_input title "Enter title of post: "
    get_line_input name "Enter markdown file name without date prefix or .md suffix: "
    get_line_input permalink "Enter permalink file name without .html extension: "
    get_line_input summary "Enter post summary: "
    get_array_input tags "Enter tags associated with given post minus news tag: "

    post="---\n"
    post+="title: \"${title}\"\n"
    post+="published: false\n"
    post+="permalink: ${permalink}.html\n"
    post+="summary: \"${summary}\"\n"
    post+="tags: [news"
    for tag in "${tags[@]}"
    do
        post+=", ${tag}"
    done
    post+="]\n---\n\n\n\n{% include links.html %}"

    fname=`date +%F`
    fname+="-${name}.md"

    echo -e ${post}
    ans=
    is_yes ans "Create above post for file name: ${fname}? "
    if [[ $ans = true ]]
    then
        echo -e ${post} >"${docdir}/_posts/${fname}"
        echo Created \"${title}\" Post
    fi
} # create_post

# This function is used for creating a tooltip definition.  It will create
# the required file within the _tooltips directory and update the
# definitions.yml with the newly created tooltip.  The script will ask the
# user to define the tooltip and its definition.  It will then create the
# required file and definition.
#
# definition html file format
#
# ---
# doc_id: <name>
# product: <product>
# ---
#
# {{site.data.definitions.<name>}}
#
# Where <name> is the name of the created definition and <product> is
# the definition associated product.
#
# The _data/definitions.yml will have the following appended.
#
# <name>: "<definition>"
#
# Where the <name> is the name of the created definition and <definition> is
# the description/definition of the created definition <name>.
function create_definition {
    name=
    definition=
    product=

    get_input name "Enter definition name" true
    get_input definition "Enter definition for $name" true
    get_input product "Enter product for definition $name" true

    # Add the new definition to the definitions file
    echo "${name}: \"${definition}\"" >> _data/definitions.yml

    # Create the definition file in the _tooltips directory
    echo "---" >> _tooltips/${name}.html
    echo "doc_id: ${name}" >> _tooltips/${name}.html
    echo "product: ${product}" >> _tooltips/${name}.html
    echo "---" >> _tooltips/${name}.html
    echo >> _tooltips/${name}.html
    echo "{{site.data.definitions.${name}}}" >> _tooltips/${name}.html

    echo "Created definition: $name for product: ${product}"

} # create_definition

# This function is used for echo a front matter entry only if is was
# defined else do nothing.
# Parameters:
# - front matter name
# - front matter value
function echo_frontmatter_entry {
    # check that the correct number of parameters was passed
    check "echo_frontmatter_entry" 2 $#

    # Only print the front matter if a value was associated with the
    # passed parameter value.
    if [ ! -z "$2" ]
    then
        echo "$1: $2"
    fi
} # echo_frontmatter_entry

# This function is used for printing the usage of this script with its
# command line options and exiting.
function usage {
    echo $0: [-h] [-v] [-D] type...
    echo "  -D: print this scripts calls"
    echo "  -v: print debug statements while executing this script"
    echo "  -h: prints this message and exists"
    echo
    echo "  type: The different type of pages that you want to create"
    echo "        available types:"
    echo
    pages=(page definition post tag)
    for page in "${pages[@]}"
    do
        echo "      - ${page}"
    done
    exit 1
} # usage

########################################################################

if [ -f "$rcfile" ];
then
   # source in the commonrc file to include common functions and variables
   source $rcfile
fi

while getopts "Dvh" o; do
    case "${o}" in
        D) set -x
            ;;
        v) debug=true
	        ;;
        h) usage
            ;;
        *) echo o=${o}
            ;;
    esac
done

# shift all processed command line parameters
shift $((--OPTIND))

# iterate through each of the remaining types of pages to create
while [[ $# > 0 ]]
do
    trace Processing page type: $1
    case "$1" in
        page) echo Processing page
            create_page
            ;;
        post) echo Processing post
            create_post
            ;;
        definition) echo Processing definition
            ;;
        tag) echo Processing tag
            create_tag
            ;;
        *) usage
    esac
    shift
done

#  date +"%B%e, %Y"
