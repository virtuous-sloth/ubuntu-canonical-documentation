#!/usr/bin/bash

name=$(basename "$0" | sed -e 's/\.sh$//')
url=$(echo $name | sed -e 's/_.*//' | tr - /)

curl --silent "https://$url" \
	| htmlparser 'json{}' \
	| jq '.. | objects | select(.text == "Help improve this document in the forum") | .href' \
	| tr '"' "\`" \
	> "$name".md
