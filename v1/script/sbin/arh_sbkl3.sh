#!/bin/bash
#производим архивирование устаревших данных
#route del default gw 192.168.77.1
dates=$(date +"%d%m%Y")
dates_now=$(date +"%d%m%Y%M%H")

#echo $dates
#echo "sleep"
#sleep 15
id_comp=`/bin/z_macid`
#dir1=/shipbox/temp
dir1=/sbkl/data

dir2=/sbkl/arh
#7z a $dir1/$id_comp-$dates.7z $dir1/gps.txt $dir1/i7019.txt $dir1/i7080.txt -mx=9
name4find="$id_comp-$dates*.7z" #ищем часовые архивы
old_files=`find -P $dir1 ! -name $name4find | grep "7z"`
if [[ $old_files ]]; then #если не пусто то архивируем и удаляем
7z a $dir2/$id_comp-$dates $old_files -mx=9
sleep 12
arr_old_files=($old_files) #преобразуем в массив и удаляем файлы в цикле
for s in "${arr_old_files[@]}"; do
#cat $s >> $s.txt
unlink $s
#echo $s
done
fi
#echo $dates_now > $dir2/$dates_now.txt
