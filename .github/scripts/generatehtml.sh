cp custom_html/* .
cp custom_links/* .

for file in images/*; do
    basename=$(basename -s ".png" $(basename -s ".gif" $file))
    echo $basename
    web_file="$basename.html"
    echo "$basename"
    echo "<html>" > $web_file
    echo "<head>" >> $web_file
    echo "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">" >> $web_file
    echo "<link rel=\"stylesheet\" href=\"custom_css/main.css\">" >> $web_file
    echo "</head>" >> $web_file
    echo "<body style=\"background-color:black; text-align:center;\">" >> $web_file
    echo "<a href="page_index.html"><img src=\"$file\" alt=\"$basename\"></a>" >> $web_file
    echo "</body>" >> $web_file
    echo "</html>" >> $web_file
done

target_file="page_index.html"
latest_reference_file="latest.html"
echo "$basename"
echo "<html>" > $target_file
echo "<head>" >> $target_file
echo "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">" >> $target_file
echo "<link rel=\"stylesheet\" href=\"custom_css/page_index.css\">" >> $target_file
echo "</head>" >> $target_file
echo "<body>" >> $target_file
echo "<div class=\"main\">" >> $target_file
echo "<ul>" >> $target_file
#echo "<li style=\"font-family: Verdana, sans-serif;font-size: 36px;\"><a href="index.html">home</a></li>" >> $target_file
#echo "<li><a href="$latest_reference_file">latest</a></li>" >> $target_file

count=0
# Combine all numbered html and link files, sort descending (so newest first)
for file in $(ls -r [0-9]*.html [0-9]*.link 2>/dev/null); do
  ext="${file##*.}"
  basename=$(basename "$file" ."$ext")
  display_name=$(echo "$basename" | cut -d "_" -f2-)

  if [ "$ext" = "html" ]; then
    echo "<li><a href=\"$file\">$display_name</a></li>" >> $target_file
  elif [ "$ext" = "link" ]; then
    source "$file"
    # URL and NAME from inside .link file
    echo "<li><a href=\"$URL\" target=\"_blank\" rel=\"noopener noreferrer\">${NAME:-$URL}</a></li>" >> $target_file
  fi

  count=$((count+1))
  if [ "$count" -eq 3 ]; then
    echo "<div class=\"window-gap\"></div>" >> $target_file
  fi
done

echo "</ul>" >> $target_file
echo "</div>" >> $target_file
echo "</body>" >> $target_file
echo "</html>" >> $target_file

latest_page=$(ls -r [0-9]*html | head -1)
echo "<meta http-equiv=\"Refresh\" content=\"0; url=$latest_page\" />" > $latest_reference_file
