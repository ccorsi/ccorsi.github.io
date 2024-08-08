
# Generate all Jekyll static pages that don't require any setup files
for line in `cat selfcontained-sites`; do
   echo line=$line
   IFS= read -ra pair <<< $line
   # frontmatter+=`echo "${pair[0]}: ${pair[1]}\n"`
   # set -- $line
   site=${pair[0]}
   extra=${pair[@]}
   echo site=$site
   echo extra=$extra
done

while IFS=' ' read -ra pair
do
   echo pair=${pair[@]} length=${#pair[@]}
   site=${pair[0]}
   extra=${pair[@]:1}
   echo site=$site
   echo extra=$extra
done < selfcontained-sites

