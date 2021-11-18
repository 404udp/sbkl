#!/bin/bash
############################### reset i7080
TTY="/dev/ttyS1"
dir_del="/sbkl/del"
fls="$dir_del/i7080.alog"
dtm=`date +"%d%m%y_%H:%M:%S"`
echo -e "\t\n ============BeginCountCycle \t\n" >> $fls;
echo -e "\t\n ======reset_counter_DaTime:$dtm\n\t" >> $fls
RESULT=$(cat $TTY >> $fls &
echo -e '$02M\r' > $TTY; sleep 6;#идентифицируем модуль
echo -e '$02M\r' > $TTY; sleep 6;
kill %cat)
echo -e "\n" > $TTY;
SLEEP6=6;SLEEP5=5;SLEEP4=4;SLEEP3=3;
RESULT=$(cat $TTY >> $fls &
echo -e "\n0.02.0.1. "`date +"%H:%M:%S"`"\t*" >> $fls;
echo -e '$0260\r' > $TTY; sleep $SLEEP6;
echo -e "\n0.02.0.2. "`date +"%H:%M:%S"`"\t*" >> $fls;
echo -e '$0260\r' > $TTY; sleep $SLEEP3;
echo -e "\n0.02.0.3. "`date +"%H:%M:%S"`"\t*" >> $fls;
echo -e '$0260\r' > $TTY; sleep $SLEEP6;
echo -e "\n0.02.1.1. "`date +"%H:%M:%S"`"\t*" >> $fls;
echo -e '$0261\r' > $TTY; sleep $SLEEP6;
echo -e "\n0.02.1.2. "`date +"%H:%M:%S"`"\t*" >> $fls;
echo -e '$0261\r' > $TTY; sleep $SLEEP3;
echo -e "\n0.02.1.3. "`date +"%H:%M:%S"`"\t*" >> $fls;
echo -e '$0261\r' > $TTY; sleep $SLEEP6;

dtm=`date +"%d%m%y_%H:%M:%S"`
#echo "resetStop7080_$dtm" >> $dirlog
############# готовим для раннего пользования данные ресета 7080


f78a="$dir_del/i7080.alog"


cat $f78a | tr '\r' '\n' > $f78a.txt

sed -i "s/\!027//g" $f78a.txt

sed -i "s/\!02/OK-reset/g" $f78a.txt
cat $f78a.txt | tr '\n' '\t' > $f78a.22.txt
sed -i "s/*\tOK-reset/OK-reset\n/g" $f78a.22.txt # *таб и ОКресет на ОКресет и перевод строки
##sed -i "s/\t\*\t/\t/g" $s.2.txt
sed -i "s/\t\t/\n/g" $f78a.22.txt # два слеша меняем на конец строки
##sed -i "s/\!02/OK-reset/g" $s.txt
sed -i -r '/^.{,7}$/d' $f78a.22.txt # пустые строки короче 7 символовов
sed -i -r 's/^[ \t]*//;s/[ \t]*$//' $f78a.22.txt #в начале лишние табуляции
##sed -i -r "s/\t\/*\t/\t/g" $s.2.txt
##sed -i '/*/d' $s.2.txt #remove lines *
sed -i -r '/^.{,7}$/d' $f78a.22.txt # пуст строки и короче 7 символов
sed -i -r "s/\t\*\t/\t/g" $f78a.22.txt # delete tab*tab to tab
sed -i '/*/d' $f78a.22.txt #remove lines *
#unlink $s #удаляем исходн.файл
#done
cp $f78a.22.txt $f78a.reset
kill %cat)