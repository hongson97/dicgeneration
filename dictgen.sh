#install tool
echo "Install dependency tools:"
go install github.com/hakluke/hakrawler@latest
go install github.com/tomnomnom/waybackurls@latest

echo "Done"

if [ -d "output" ]; then
    echo "$DIRECTORY does exist."
else
    mkdir "output"
fi

if [ -d "output/js" ]; then
    echo "$DIRECTORY does exist."
else
    mkdir "output/ls"
fi

while read line; do
# reading each line
$output = "output/js" + $line
echo $line | hakrawler >> $output
echo $line | waybackurls >> $output
n=$((n+1))
done < $1