sort -n | awk '{ print $0 - old; old = $0 } END { print 3 }' old=0 | sort | uniq -c | awk '{ a[$2] = $1 } END { print a[1] * a[3] }'
