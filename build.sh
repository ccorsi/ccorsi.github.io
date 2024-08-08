#----------------------------------------
#
# Filename:    build.sh
#
# Description: Used to build a Jekyll web site.
#
# Created by:  Claudio Corsi on August 05, 2024
#
# Copyright (c) 2024 Claudio Corsi. All rights reserved.
#
#----------------------------------------

# NOTE: This script is not being used any longer and has been replaced by the
#       run.sh script that provides more flexibility than what this script
#       originally offered.

# export PATH=/c/tools/ruby/3.0.2-1/bin:$PATH

# update the bundle for the given jekyll build
bundle update

# This requires ruby version 3.2.3 because of the dependencies
bundle exec jekyll build -V --future
