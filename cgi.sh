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
# I've seen numerous ways to do this in bash, but this is by far the simplest
declare -A _QUERY
function parse_query {
	IFS='&'
	for i in $QUERY_STRING ; do
		_QUERY[${i%%=*}]=${i##*=}
		# An unencoded + in the query component means a space
		# Don't stare at this too hard, it will hurt your eyes
		_QUERY[${i%%=*}]=${_QUERY[${i%%=*}]//+/ }
	done
	unset IFS
}

# Decode a url encoded string
function url_decode {
	local __string="$@"
	# Replace % with \\x then have bash evaluate it
	__string=${__string//\\%/\\x}
	__string=$(echo -e "$__string")
	
	echo "$__string"
}

# Encode a string to url safe characters
function url_encode {
	local __string="$@"
	
	# Hopefully I got all the ones here that need it
	__string=${__string//%/%25} 
	__string=${__string//' '/%20}
	__string=${__string//!/%21} 
	__string=${__string//\"/%22} 
	__string=${__string//#/%23}
	__string=${__string//\$/%24}
	__string=${__string//\&/%26} 
	__string=${__string//\'/%27}
	__string=${__string//(/%28} 
	__string=${__string//)/%29}  
	__string=${__string//\*/%2a}
	__string=${__string//+/%2b} 
	__string=${__string//,/%2c}  
	__string=${__string//-/%2d}
	__string=${__string//\./%2e}
	__string=${__string//\//%2f} 
	__string=${__string//:/%3a}
	__string=${__string//;/%3b} 
	__string=${__string//</%3c}  
	__string=${__string//=/%3d}
	__string=${__string//>/%3e} 
	__string=${__string//\?/%3f} 
	__string=${__string//@/%40}
	__string=${__string//\[/%5b}
	__string=${__string//\\/%5c} 
	__string=${__string//\]/%5d}
	__string=${__string//\^/%5e}
	__string=${__string//_/%5f}  
	__string=${__string//\`/%60}
	__string=${__string//\{/%7b}
	__string=${__string//|/%7c}  
	__string=${__string//\}/%7d}
	__string=${__string//\~/%7e} 
	
	echo "$__string"
}
