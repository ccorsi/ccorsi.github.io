#----------------------------------------
#
# Filename:    serve.sh
#
# Description: This script is used to start the simple Http server
#       that is part of the standard Python distribution
#
# Created by:  Claudio Corsi on August 06, 2024
#
# Copyright (c) 2024 Claudio Corsi. All rights reserved.
#
#----------------------------------------

#!/bin/sh
#

PATH=/c/tools/python/3/12/3:$PATH

# Only process local connections by using the --bind option.
python -m http.server --bind 127.0.0.1
