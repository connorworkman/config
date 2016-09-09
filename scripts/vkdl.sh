#!/bin/sh

eurl() {
    local LC_ALL=C c
    while IFS= read -r -n1 -d '' c
    do
        if [[ $c = [[:alnum:]] ]]
        then
            printf %s "$c"
        else
            printf %%%02x "'$c"
        fi
    done
}
openvk() {
        local vkurl search
        search="$1"
        while [[ ! -z "$2" ]]
        do
                shift && search="$search+$1"
        done
	vkurl='http://vk.com/audio?q='"$(printf '%s' "$search" | eurl | tr -d \')"
		chromium "$vkurl" &
	return 0
}
openmp3fy() {
        local vkurl search
        search="$1"
        while [[ ! -z "$2" ]]
        do
                shift && search="$search+$1"
        done
	vkurl='http://www.mp3fy.com/music/search.php?s=foo&artist=bar+foo+bar&type=track&page=1'
	return 0
}

declare -a vkarray
readarray -t vkarray <"${1:-/dev/stdin}"
let i=0
while (( ${#vkarray[@]} > i )); do openvk "${vkarray[i++]}"; done
vkvar=$(while (( ${#vkarray[@]} > i )); do openvk "${vkarray[i++]}"; done | tr -d \')
if jobs %%; then wait $!; fi
echo
