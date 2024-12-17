#!/bin/bash
#
# Copyright 2024 Claudio Corsi
#
# This simple script will setup and build the different sub-web sites
# that are part of this repository.  It was designed to allow me to
# be able to generate different types of sub-web sites using different
# techniques from tools, like Jekyll, to packages, like Beautiful and
# Documentation Jekyl Themes, to providing setup type instructions that
# can be related to a given type of sub-web site build.
#
# The current incarnation does require some base level tools to be able
# to build the different sub-web sites.  You will then need to have 
# ruby installed on your system.
#
# 	$ export PATH=<RUBY_HOME>/bin:$PATH
#
# The other requirement is that you need to include the bundle gem as
# part of the ruby installation that will be used to build the sub-web
# sites.
#
# 	$ gem install bundle
#
# This will allow us to be able to use the Gemfile to properly setup
# each individual sub-web site build with its required dependencies
# to correctly build the sub-web site.
#
######################################################################

########################## FUNCTIONS ###########################

# This function is used to setup the required files that will be
# used with the jekyll static web site build using the Beautiful
# Jekyll theme.
# Parameters:
# 	- website directory name
function setup_beautiful {
    trace Calling setup_beautiful with parameters: $*
   
    # Insure that the required number of parameters was passed
    check "setup_beautiful" 1 $#

    site=$1

    trace Copying required Beautiful Jekyll files to the $site directory

    # We initially need to copy all of the required files used by
    # each jekyll sub web site.
    cp -rpv _common/* _site/${site}
}

# This function is used to setup the required files that will be
# used by the jekyll static web site build using the Documentation
# Theme Jekyll theme.
# Parameters:
# 	- website directory name
function setup_doc_theme {
    trace Calling setup_doc_theme with parameters: $*

    # Insure that the required number of parameters was passed
    check "setup_doc_theme" 1 $#

    site=$1

    trace Copying required Documentation Theme Jekyll files to the $site directory

    # We initially copy all the required files needed to build the documentation static
    # web site using jekyll
    copy_files "documentation-src.lst" "${site}"
}

# This function is used to build the different sites that are part of this repository
# It is designed to simplify the process of building the sites.
# Parameters:
# 	- input file with sites to build
# 	- build function
# 	- setup function
function build_site {
   trace Calling build_site with parameters: $*

   # Insure that the required number of parameters was passed
   check "build_site" 3 $#

   # Assign the passed parameters to local variables for better readability
   sites=$1
   build=$2
   setup=$3

   # Insure that the file exists
   check_file_exists "build_site" $sites

   while read site
   do
      trace Building site $site
      eval ${build} ${site} ${setup}
   done < $sites
}

# This function is used to copy files from a source to a destination that will be
# used to build or are files that are part of the built site.
# Parameters:
# 	- input file contain source and destination
# 	- destination directory, defaults to _site
function copy_files {
   trace Calling copy_files with parameters: $*

   # Insure that the required number of parameters was passed
   check "copy_files" 1 $#

   file=$1
   dest=${2:-_site}

   # Insure that the file exists
   check_file_exists "copy_files" $file

   while read line
   do
      trace Processing line $line
      set -- $line
      if [ -z "$2" ];
      then
	      trace Copying files from $1 to ${dest}
         cp -rpv ${1} ${dest}
      else
	      trace Copying files from $1 to ${dest}/$2
         cp -rpv ${1} ${dest}/$2
      fi
   done < $file
}

# This function is used to build a particular static web site using
# Jekyll
# Parameters:
# 	- website directory name
# 	- website setup function
# 	- use bundle command
function build_jekyll_site {
   trace Calling build_jekyll_site with parameters: $*

   # Insure that the required number of parameters was passed
   check "build_jekyll_site" 3 $#

   site=$1
   setup=$2
   usebundle=$3
   # shift two since jekyll extra args for the build are located
   shift 3

   trace Creating site root directory _site/${site}
   # Create the required site root directory used by jekyll
   mkdir -p _site/${site}

   # call the setup function before building the site
   eval ${setup} ${site}

   # move into the site build directory
   pushd ${site}

   if [ "$update" = true ]; then
      trace "Updating dependencies for site ${site}"
      # Update the dependencies of the current build site
      bundle update
   fi

   if [ ! -z "$1" ]
   then
      # set the extra jekyll build args using the passed optional parameter settings
      JEKYLL_EXTRA_BUILD_ARGS=$*
      trace "Setting JEKYLL_EXTRA_BUILD_ARGS variable to: \"${JEKYLL_EXTRA_BUILD_ARGS}\""
   fi

   if [ "$usebundle" = true ]
   then
      cmd="bundle exec"
   else
      cmd=
   fi
   # This requires ruby version 3.2.3 because of the dependencies
   if [ "$start" = true ] ; then
      trace "Starting Jekyll watch build for site ${site}"
      eval ${cmd} jekyll build -V --watch --trace --future -d ../_site/${site} ${JEKYLL_EXTRA_BUILD_ARGS} &
   else
      trace "Starting Jekyll build for site ${site}"
      eval ${cmd} jekyll build -V --trace --future -d ../_site/${site} ${JEKYLL_EXTRA_BUILD_ARGS} &
   fi

   if [ ! -z "${JEKYLL_EXTRA_BUILD_ARGS}" ]
   then
      # reset the extra jekyll build args
      JEKYLL_EXTRA_BUILD_ARGS=
      trace "Cleared the setting for the JEKYLL_EXTRA_BUILD_ARGS variable"
   fi

   # move back to the top-level directory
   popd
}

# This is used in the case that the setup method doesn't have to perform any
# setup.  This method can also be used for other instances that a calling
# function doesn't require any actions.
function setup_noop {
    # This function does nothing and is useful when there is nothing to setup
    trace Calling setup_noop with parameters: $*
}

function usage {
   echo "Usage: $0 -s -k -d -u -w -t -v -h [sites]"
   echo "   -s: start a local http server"
   echo "   -k: kill all running ruby processes"
   # We now always delete the _site directory
   # echo "   -d: delete the _site directory"
   echo "   -u: update the required dependencies for each generated web site"
   echo "   -w: start the jekyll build process and enable increment build"
   echo "   -t: only build the top level _site web site"
   echo "   -v: enable tracing of calls"
   echo "   -D: enable command echo"
   echo "   -h: print this message and exit"
   echo ""
   echo "  sites: zero or more sites to be processed"
   exit 1
}

#####################################################################

# Get the fully qualified path name to the commonrc file
rcfile=`dirname $0`/commonrc

if [ -f "$rcfile" ];
then
   # source in the commonrc file to include common functions and variables
   source $rcfile
fi

# Process the command line options such that we can determine what
# we want to perform during the building and/or running of the
# jekyll static web site build{s} and static pages inclusions.
#
# Initialize options
start=false
stop=false
# Reason explained above
# delete=true
update=false
watch=false
top=false
sites=()
# FYI: The debug variable is defined within the commonrc file
# debug=false

while getopts "Dskuwvht" o; do
   case "${o}" in
      t) top=true
         ;;
      s) start=true
         ;;
      k) stop=true
	      ;;
      #d) delete=true
	      #;;
      u) update=true
	      ;;
      w) watch=true
	      ;;
      v) debug=true
	      ;;
      D) set -x
         ;;
      h) usage
   esac
done

if [ $OPTIND -le $# ]
then
   shift $((OPTIND-1))
   for site in $*
   do
       sites+=($site)
       shift
   done
# else
# TBD: Adding the "*" character to the array will only gather all of the file names which is
#      not what I wanted to add to the sites array.  I wanted to add the "*" character only.
#    sites+=("*")
fi

echo sites=${sites[@]}

trace "start is set to $start"
trace "stop is set to $stop"
# trace "delete is set to $delete"
trace "update is set to $update"
trace "watch is set to $watch"

if [ "$stop" = true ]; then
   trace Searching for ruby processes to kill
   # Find all running ruby applications and kill them
   for proc in `ps -s | grep ruby | awk '{ print $1 }'`;
   do
      echo killing running ruby process pid: $proc;
      kill $proc
   done
fi

# TODO: Since we are now using Jekyll to build the main site.  We should delete
# the _site directory by default.
# if [ "$delete" = true ]; then
   # Determine if the _site directory already exists
   if test -d _site; then
      trace Deleting existing _site directory
      # delete files from the _site directory
      rm -rf _site
   fi
# fi

trace Creating the _site directory
# Create the _site directory
mkdir _site

if [ "$update" = true ]; then
   trace "Updating dependencies for site _site"
   # Update the dependencies of the current build site
   bundle update
fi

# This requires ruby version 3.2.3 because of the dependencies
if [ "$start" = true ] ; then
   # Delete the _site/index.htm file because we will wait until this file exists.
   # if test -f _site/index.htm
   # then
      # rm _site/index.htm
   # fi
   trace "Starting Jekyll watch build for top level site _site"
   eval bundle exec jekyll build -V --watch --trace --future &
   # NOTE: The following is not required any longer because we are using the keep_files
   #  Jekyll feature to not delete the other generated web sites.
   # We need to wait until Jekyll has generated the _site/index.htm
   # file since it deletes the _site directory
   # while ! test -f _site/index.htm
   # do
   #    sleep 1
   # done
else
   trace "Starting Jekyll build for top level site _site"
   eval bundle exec jekyll build -V --trace --future &
fi

# NOTE: The commented out script code was part of the original work done
#       provide the ability to generate the different types of web site
#       generation.  The newer version is more flexible than this and
#       has replaced with following script code.

# # Generate all Jekyll static pages that uses the beautiful jekyll theme
# while read site; do
#    build_jekyll_site ${site} setup_beautiful true
# done < beautiful-sites

# # Generate all Jekyll static pages that uses the documentation jekyll theme
# while read site; do
#    build_jekyll_site ${site} setup_doc_theme true
# done < documentation-sites

# # Generate all Jekyll static pages that don't require any setup files
# while IFS=' ' read -ra pair
# do
#    site=${pair[0]}
#    usebundle=${pair[1]}
#    extra=${pair[@]:2}
#    build_jekyll_site ${site} setup_noop ${usebundle} $extra
# done < selfcontained-sites

if [ "$top" = false ]
then
   # Generate all Jekyll static pages for the given sites
   while IFS=' ' read -ra line
   do
      if [ ! "${#line[@]}" -lt "4" ]
      then
         # this is used to determine how many parameters are assigned to the extra arguement
         len=0
         # determine if the line contains the comment character
         if [[ ${line[@]} =~ '#' ]]
         then
            # loop through the array until we find the comment character
            for last in "${!line[@]}"
            do
               if [[ "${line[$last]}" =~ "#" ]]
               then
                  # we found the comment character thus break out of for loop
                  break
               fi
            done
            # determine if the comment character is located beyond the 4th entry
            if [ "$last" -gt "4" ]
            then
               len=$(($last - 4))
            fi
            # reassign the line variable to only include required data and purge comment
            line=(${line[@]:0:${last}})
         else
            # determine if the line contains more than 4 entries
            if [ "${#line[@]}" -gt "4" ]
            then
               len=$((${#line[@]} - 4))
            fi
         fi
         if ! test -z $line
         then
            site=${line[0]}
            build=${line[1]}
            setup=${line[2]}
            usebundle=${line[3]}
            extra=${line[@]:4:${len}}
            # The following was the original script code but it didn't provide the
            # ability to selectively build and run a subset of the web sites.
            # trace Executing command: ${build} ${site} ${setup} ${usebundle} $extra
            # eval ${build} ${site} ${setup} ${usebundle} $extra

            if [ ${#sites[@]} -gt 0 ]
            then
               # This updated script code allows one the ability to build and run a
               # subset of the web sites to allow for quicker turnaround.
               for s in "${sites[@]}"
               do
                  if [[ "$site" =~ "$s" ]]
                  then
                     trace Generating web site: ${site}
                     # we found the comment character thus break out of for loop
                     trace Executing command: ${build} ${site} ${setup} ${usebundle} $extra
                     eval ${build} ${site} ${setup} ${usebundle} $extra
                     break
                  fi
               done
            else
               # Start all web sites
               trace Executing command: ${build} ${site} ${setup} ${usebundle} $extra
               eval ${build} ${site} ${setup} ${usebundle} $extra
            fi
         fi
      fi
   done < sites
fi

# The following script action is not needed any longer since we are using
# Jekyll to build the top-level web site.
# Copy all the required common files to the _site directory
# for source in `cat common`; do
   # trace Copying files from ${source} to _site
   # cp -rpv ${source} _site
# done

# Start the server if requested else exit the script
if [ "$start" = true ]; then
   cd _site
   if [ -z "$PYTHON_HOME" ]; then
      cmd=python
   else
      cmd=${PYTHON_HOME}/python
   fi
   echo Starting http server to serve generated site: _site
   # We are only going to process local connections for security reasons
   ${cmd} -m http.server --bind 127.0.0.1
else
   # Wait for all of the Jekyll's build completed
   wait $(jobs -p)
   echo All Jekyll builds have completed
fi

