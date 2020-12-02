#!/bin/bash
IFS+=-:
while read min max letter pwd; do
    [[ $pwd =~ ^([^$letter]*$letter[^$letter]*){$min,$max}$ ]] && (( ++ok ))
done
echo $ok
