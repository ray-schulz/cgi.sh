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

# Parse the query string into an associative array of key=>value pairs
declare -A _QUERY
function parse_query() {
	IFS='&'
	for i in $QUERY_STRING ; do
		_QUERY[${i%%=*}]=${i##*=}
	done
	unset IFS
}

# Decode a url encoded string
function url_decode() {
	local __string=$1
	
	# Decode spaces
	__string=${__string//+/ }
	
	# Decode the %xx stuff
	# Replace % with \x then have bash evaluate it
	__string=${__string//\%/\\x}
	__string=$(echo -e "$__string")
	
	echo "$__string"
}


