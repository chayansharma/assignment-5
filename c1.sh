expression=""
while [ "$1" != "" ]; do
    expression=$(echo "$expression""$1")
    shift
done

echo "$expression" | bc -l
