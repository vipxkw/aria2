#!/bin/bash
path=$3 
downloadpath='/usr/local/Download'
filename=''
if [ $2 -eq 0 ]; then
     exit 0
fi

filepath=${path%/*};

if [ "$filepath" = "$downloadpath" ] && [ $2 -eq 1 ]; then #如果下载的是单个文件
      filename=${path// /\\ }                                             
      filename=${filename//[/\\[}                                             
      filename=${filename//]/\\]}                                             
      filename=${filename//&/\\&}
      filename=${filename//@/\\@}
      echo $filename >>/root/name.txt
      eval /usr/local/etc/OneDrive/onedrive -f /Download  $filename >>/root/log.txt
      eval rm -rf $filename
else  #下载的是文件夹
        echo $filepath >>/root/name.txt
        filename_left=${filepath#*Download/}
        echo $filename_left >>/root/name.txt
        filename_right=${filename_left%/*}
        echo $filename_right >>/root/name.txt
        filename=${filename_right// /\\ }
        filename=${filename//[/\\[}
        filename=${filename//]/\\]}
        filename=${filename//&/\\&}
        filename=${filename//@/\\@}
        echo $filename >>/root/name.txt
        #time=$(date "+%Y%m%d-%H%M%S")
        newFilePath=${downloadpath}/${filename}
        #newFilePath=${downloadpath}/${filename}
        echo $newFilePath >>/root/name.txt
        #cd $downloadpath
        #eval mv $filename/ $time/
        eval /usr/local/etc/OneDrive/onedrive-d -f /Download  $newFilePath >>/root/log.txt
        eval rm -rf $newFilePath
fi

exit 0
