expression=""
while [ "$1" != "" ]; do
	expression=$(echo "$1")
    shift
done

echo "$expression" | bc -l
