#!/usr/bin/bash

name=$(basename "$0" | sed -e 's/\.sh$//')
url=$(echo $name | sed -e 's/_.*//' | tr - /)

curl --silent "https://$url" \
	| htmlparser 'a[class="p-link"] json{}' \
	| jq -r '["Doc Site", "URL"], (.[] | [.text, .href]) | @csv' \
	| tr '"' "\`" \
	| csvlook > "$name".md
