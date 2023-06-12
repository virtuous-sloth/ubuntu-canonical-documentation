#!/usr/bin/bash

name=$(basename "$0" | sed -e 's/\.sh$//')

curl --silent https://docs.ubuntu.com/ \
	| htmlparser 'a[class="p-link"] json{}' \
	| jq -r '["Doc Site", "URL"], (.[] | [.text, .href]) | @csv' \
	| tr '"' "\`" \
	| csvlook > "$name".md
