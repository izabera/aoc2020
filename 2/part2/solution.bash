#!/bin/bash
IFS+=-:
while read a b letter pwd; do
    s=${pwd:a-1:1}${pwd:b-1:1}
    [[ ${s//$letter} = ? ]] && (( ++ok ))
done
echo $ok
