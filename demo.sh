#!/bin/bash

# Copyright 2013 Ray Schulz

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# https://github.com/ray-schulz/cgi.sh

# Demonstration of how to use cgi.sh

# Source cgi.sh so the functions and variables will be available
. cgi.sh

# QUERY_STRING isn't defined, so let's set it to something interesting
# This would normally be set by the web server
QUERY_STRING="foo=bar&bohica&sn=afu"

# parse_query will fill the associative array _QUERY with key=>value pairs
parse_query

# So you can see what happened
for i in "${!_QUERY[@]}" ; do
	echo "_QUERY[$i]=${_QUERY[$i]}"
done

# Got some url encoded stuff? Use url_decode to decode it
# Don't do this to QUERY_STRING, else bad things could happen in parse_query
url_encoded="that's+my+m%26m!"
url_decoded=$(url_decode $url_encoded)
echo "before: $url_encoded"
echo "after:  $url_decoded"






