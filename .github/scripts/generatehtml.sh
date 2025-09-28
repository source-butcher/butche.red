cp custom_html/* .

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
echo "<li><a href="$latest_reference_file">latest</a></li>" >> $target_file

#for file in [!index]*html;
for file in `ls -r [0-9]*html`; do # need to order for numbers over 9
  basename=$(basename $file ".html")
  echo $basename
  display_name=$(echo $basename | cut -d "_" -f2-10000)
  web_file="$basename.html"
  echo "<li><a href="$web_file">$display_name</a></li>" >> $target_file
  if [ "$count" -eq 4 ]; then #insert gap after fourth link
    echo "</ul>" >> $target_file
    echo "<div class=\"window-gap\"></div>" >> $target_file
    echo "<ul>" >> $target_file
  fi
done
echo "<li><a href="https://notjealo.us" target="_blank" rel="noopener noreferrer">notjealo.us</a></li>" >> $target_file
echo "</ul>" >> $target_file
echo "</div>" >> $target_file
echo "</body>" >> $target_file
echo "</html>" >> $target_file

latest_page=$(ls -r [0-9]*html | head -1)
echo "<meta http-equiv=\"Refresh\" content=\"0; url=$latest_page\" />" > $latest_reference_file
