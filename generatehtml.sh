for file in images/*; do
    basename=$(basename -s ".png" $(basename -s ".gif" $file))
    echo $basename
    web_file="$basename.html"
    echo "$basename"
    echo "<html>" > $web_file
    echo "<head>" >> $web_file
    echo "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">" >> $web_file
    echo "</head>" >> $web_file
    echo "<body style=\"background-color:black\">" >> $web_file
    echo "<a href="page_index.html"><img src=\"$file\" alt=\"$basename\" style=\"width:auto;height:100%;display:block;margin:auto;\"></a>" >> $web_file
    echo "</body>" >> $web_file
    echo "</html>" >> $web_file
done

target_file="page_index.html"
latest_reference_file="latest.html"
echo "$basename"
echo "<html>" > $target_file
echo "<head>" >> $target_file
echo "<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">" >> $target_file
echo "<link rel=\"stylesheet\" href=\"page_index.css\">" >> $target_file
echo "</head>" >> $target_file
echo "<body style=\"text-align: center;background-color:black\">" >> $target_file
echo "<ul style=\"width:auto;height:100%;display:block;margin:auto;\">" >> $target_file
echo "<li style=\"font-family: Verdana, sans-serif;font-size: 36px;font-color: red\"><a href="index.html">home</a></li>" >> $target_file
echo "<li style=\"font-family: Verdana, sans-serif;font-size: 36px;font-color: red\"><a href="$latest_reference_file">latest</a></li>" >> $target_file

#for file in [!index]*html;
for file in `ls -r [0-9]*html`; do # need to order for numbers over 9
  basename=$(basename $file ".html")
  echo $basename
  web_file="$basename.html"
  echo "<li style=\"font-family: Verdana, sans-serif;font-size: 36px;font-color: red\"><a href="$web_file">$basename</a></li>" >> $target_file
done

echo "</ul>" >> $target_file
echo "</body>" >> $target_file
echo "</html>" >> $target_file

latest_page=$(ls -r [0-9]*html | head -1)
echo "<meta http-equiv=\"Refresh\" content=\"0; url=$latest_page\" />" > $latest_reference_file