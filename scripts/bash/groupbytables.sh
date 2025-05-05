#!/bin/bash

INPUT_FILE=$1  # Change this to your input file name
OUT_DIR=$2
mkdir -p "$OUT_DIR"

awk '
function next_id(id) {
    # Increments a single lowercase letter: a → b → c → ...
    return sprintf("%c", 97 + int(sprintf("%d", index("abcdefghijklmnopqrstuvwxyz", id))))
}

BEGIN {
    max_group = 0
}

{
    line = $0
    match(line, /FROM[ \t]+(.*)[ \t]+WHERE/, m)
    if (!m[1]) {
        print "Skipping invalid line:", line > "/dev/stderr"
        next
    }

    key = m[1]

    if (key in group_map) {
        group = group_map[key]
        id = next_id(last_id[group])
    } else {
        max_group++
        group = max_group
        id = "a"
        group_map[key] = group
    }

    last_id[group] = id

    filename = sprintf("%02d%s.sql", group, id)
    print line > "'"$OUT_DIR"'/" filename
}
' "$INPUT_FILE"
