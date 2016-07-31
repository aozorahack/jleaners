#!/bin/bash

echo '"id","title","first","last","url","n1","n2",n3","n4","n5"'
while read -r line
do
    url=`echo $line | awk -F ',' '{print $46 }' | sed -e 's/\"//g'`
    curl -LOk $url > /dev/null 2>&1
    if [ $? -ne 0 ]
    then
        continue
    fi
    file_name=`echo $url | awk -F '/' '{print $7}' | sed -e 's/\"//g'`
    new_file_name=`echo $file_name | sed -e 's/zip/txt/g'`
    score=`unzip -c $file_name | nkf -w | ./header_footer_cut.rb | ./mecab.rb jlpt.csv`
    rm -rf $file_name
    title=`echo $line | awk -F ',' '{print $2 }'`
    first_name=`echo $line | awk -F ',' '{print $16 }'`
    last_name=`echo $line | awk -F ',' '{print $17 }'`
    doc_id=`echo $line | awk -F ',' '{print $1 }'`
    html_url=`echo $line | awk -F ',' '{print $51 }'`
    echo "$doc_id,$title,$first_name,$last_name,$html_url,$score"
done < $1
