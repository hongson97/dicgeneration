#install tool
echo "Install dependency tools:"
go install github.com/jaeles-project/gospider@latest
go install github.com/hakluke/hakrawler@latest
go install github.com/tomnomnom/waybackurls@latest

echo "Done"

if [ -d "output" ]; then
    echo "[+] Output folder is exist."
else
    mkdir "output"
fi

if [ -d "output/js" ]; then
    echo "[+] js folder is exist."
else
    mkdir "output/js"
fi
start=$(date +%s)

while read domain; do
# reading each line
clean_domain=`echo $domain | sed -E 's/^\s*.*:\/\///g'`
outputfolder=output/js/$clean_domain
mkdir $outputfolder
echo $domain | gospider -q >> $outputfolder/gospider.txt
echo $domain | waybackurls >> $outputfolder/waybackurls.txt
cat $outputfolder/waybackurls.txt | unfurl pfolder -u > directory.txt
cat $outputfolder/waybackurls.txt | unfurl pfile -u > filename.txt
#echo $output
n=$((n+1))
done < $1
end=$(date +%s)
echo "Elapsed Time: $(($end-$start)) seconds"