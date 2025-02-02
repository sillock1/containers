#!/usr/bin/env bash
version="$(curl -sX GET https://api.github.com/repos/openttd/openttd/releases | jq -r 'first | .tag_name' 2>/dev/null)"
version="${version#*v}"
version="${version#*release-}"
printf "%s" "${version}"
