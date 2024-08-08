#!/bin/sh -x
#----------------------------------------
#
# Filename:    createpage.sh
#
# Description: This script is used to create a markdown page.
#
# Created by:  Claudio Corsi on July 03, 2024
#
# Copyright (c) 2024 Claudio Corsi. All rights reserved.
#
#----------------------------------------

############################### Functions ##############################

function test {
    echo Test
} # test

# This function is used for a test of determine if this works with 
# multiple lines of information being added before completing definition.
function testme {
    echo It worked
} # testme

# This function is used for to determine if a function can be created that
# will include parameters as part of its definition
# Parameters:
# - parameter 1
# - parameter 2
function fcn_with_parameters {
    echo It worked!!!!
} # fcn_with_parameters

function load_page_types {
    trace Inside load_page_types method
    check_args "load_page_types" 1 $#
    check_file_exists $1

    pages=() # initialize the pages array

    while read line
    do
        trace Processing line = $line
        set -- $line
        page=$1
        pages+=($page)
        layout=$2
        pages_layouts+=($layout)
        shift 2
        desc=$*
        pages_desc+=("$desc")
    done < $1

    for idx in "${!pages[@]}"
    do
        echo pages[$idx] = ${pages[$idx]}
        echo pages_layouts[$idx] = ${pages_layouts[$idx]}
        echo pages_desc[$idx] = ${pages_desc[$idx]}
    done
}

function check_file_exists {
    if [ ! -f $1 ];
    then
        echo File $1 doesn\'t exist
        exit 1
    fi
}

function check_args {
    fcn=$1
    min=$2
    cnt=$3

    if [[ -z "$fcn" || -z "$min" || -z "$cnt" ]];
    then
        echo Missing required check_args arguments,  Required:
        echo \t function name
        echo \t minimum arguments required
        echo \t number of arguments passed
        exit 1
    fi

    if [ "$cnt" -lt "$min" ];
    then
        echo Missing arguments for function $fcn, required $min passed $cnt
        exit 1
    fi
}

function trace {
    if [ $debug = true ];
    then
        echo $*
    fi
}

function usage {
    echo usage: $0 [-d]
    echo \t d - enable debug messages
    echo
    echo This script will create a template of a given page
    exit 1
}

########################################################################

############################# Variables ################################

debug=true # TODO: set to false
pages=() # types of pages that can be created
pages_layouts=() # associated layouts for pages
pages_desc=() # description of pages that can be created

# title: About Ruby, Gems, Bundler, and other prerequisites
# tags: [getting_started, troubleshooting]
# keywords: [key1, key2]
# summary: "Ruby is a programming language you must have on your computer in order to build Jekyll locally. Ruby has various gems (or plugins) that provide various functionality. Each Jekyll project usually requires certain gems."
# sidebar: mydoc_sidebar
# permalink: mydoc_about_ruby_gems_etc.html
# folder: mydoc

########################################################################

load_page_types "pages.lst"