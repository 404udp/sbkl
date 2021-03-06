#!/bin/bash

cmds="#03"
TTY="/dev/ttyS1"
dir_base="/sbkl/temp"
dir_del="/sbkl/del"
fls="$dir_del/i7019.alog"
dirlog="$dir_base/full.log"
sp_log="$dir_base/sp.log"
f78a="$dir_del/i7080.alog"
dtm=`date +"%d%m%y_%H:%M:%S"`

echo "datime$dtm" >> $fls
echo "a_datam_Start" >> $dirlog
echo "i7019_$dtm" >> $dirlog
SLEEP=6
RESULT=$(cat $TTY >> $fls & 
echo -e '$032\r' > $TTY; sleep $SLEEP;
#echo -e '$03M\r' > $TTY; sleep $SLEEP;
echo -e "$cmds\r" > $TTY; sleep $SLEEP;
#echo -e "$cmds\r" > $TTY; sleep $SLEEP;sleep $SLEEP;
echo -e "$cmds\r" > $TTY; sleep $SLEEP; sleep $SLEEP;
kill %cat)
echo "============" >> $fls
######## получим данные ресета 7080
#in_log="$dir_base/i7080_full.log"
#echo -e "============ $dtm " >> $dir_base/i7080s.txt
time0R=`grep 0.02.0 $f78a.reset | tail -n 1 | awk '{print $2}'`
#считываем последнюю строку времени сброса 0го счетчика
time1R=`grep 0.02.1 $f78a.reset | tail -n 1 | awk '{print $2}'`
echo $time0R,$time1R
####### считаем показания 7080
fls1="$dir_del/i7080.alog"
dtm=`date +"%d%m%y_%H:%M:%S"`
echo "start7080_$dtm" >> $dirlog

#fls1="$dir_del/log.1"
SLEEP3=3;SLEEP4=4;SLEEP5=5;SLEEP6=6;
echo -e "\nDaTime:$dtm\n" >> $fls1;
RESULT=$(cat $TTY >> $fls1 & 
echo -e '$02M\r' > $TTY; sleep $SLEEP6;
echo -e '$02M\r' > $TTY; sleep $SLEEP6;
echo -e "\n1.02.0.1. "`date +"%H:%M:%S"`"\t*" >> $fls1;
echo -e '#020\r' > $TTY; sleep $SLEEP5;
echo -e "\n1.02.0.2. "`date +"%H:%M:%S"`"\t*" >> $fls1;
echo -e '#020\r' > $TTY; sleep $SLEEP5;
echo -e "\n1.02.0.3. "`date +"%H:%M:%S"`"\t*" >> $fls1;
echo -e '#020\r' > $TTY; sleep $SLEEP6;
echo -e "\n1.02.0.4. "`date +"%H:%M:%S"`"\t*" >> $fls1;
echo -e '#020\r' > $TTY; sleep $SLEEP6;
echo -e "\n1.02.1.1. "`date +"%H:%M:%S"`"\t*" >> $fls1;
echo -e '#021\r' > $TTY; sleep $SLEEP5;
echo -e "\n1.02.1.2. "`date +"%H:%M:%S"`"\t*" >> $fls1;
echo -e '#021\r' > $TTY; sleep $SLEEP5;
echo -e "\n1.02.1.3. "`date +"%H:%M:%S"`"\t*" >> $fls1;
echo -e '#021\r' > $TTY; sleep $SLEEP6;
echo -e "\n1.02.1.4. "`date +"%H:%M:%S"`"\t*" >> $fls1;
echo -e '#021\r' > $TTY; sleep $SLEEP6;
kill %cat)
#echo -e "\n============BeginCountCycle\t" >> $fls1;
dtm=`date +"%d%m%y_%H:%M:%S"`
echo "stop7080_$dtm" >> $dirlog
cat $fls1 >> "$dir_del/7080.lag"
############################ clear
echo "cleaner" >> $dirlog
files=`find -P $dir_del -name '*.alog'`
arr_files=($files)
for s in "${arr_files[@]}";do
cat $s | tr '\r' '\n' > $s.txt
sed -i "s/\!027//g" $s.txt
sed -i "s/\!02/OK-reset/g" $s.txt
cat $s.txt | tr '\n' '\t' > $s.2.txt
sed -i "s/*\tOK-reset/OK-reset\n/g" $s.2.txt # *таб и ОКресет на ОКресет и перевод строки
#sed -i "s/\t\*\t/\t/g" $s.2.txt
sed -i "s/\t\t/\n/g" $s.2.txt # два слеша меняем на конец строки
#sed -i "s/\!02/OK-reset/g" $s.txt
sed -i -r '/^.{,7}$/d' $s.2.txt # пустые строки короче 7 символовов
sed -i -r 's/^[ \t]*//;s/[ \t]*$//' $s.2.txt #в начале лишние табуляции
#sed -i -r "s/\t\/*\t/\t/g" $s.2.txt
#sed -i '/*/d' $s.2.txt #remove lines *
sed -i -r '/^.{,7}$/d' $s.txt # пуст строки и короче 7 символов
sed -i -r "s/\t\*\t/\t/g" $s.2.txt # delete tab*tab to tab
sed -i '/*/d' $s.2.txt #remove lines *
unlink $s #удаляем исходн.файл
done
cp $dir_del/i7080.alog.2.txt $dir_base/i7080.log
echo "" >> $dir_base/i7080_full.log
cat $dir_del/i7080.alog.2.txt >> $dir_base/i7080_full.log
#cp $dir_del/i7019.1.txt $dir_base/i7019.txt
cat $dir_del/i7019.alog.txt >> $dir_base/i7019.txt

###################### speed
#dir1="/shipbox/temp"#dir_log="/sbkl/temp"#sp_log="/sbkl/temp/sp.log"
dtm=`date +"%d%m%y_%H:%M:%S"`
in_log="$dir_base/i7080_full.log"
echo -e "============ $dtm " >> $dir_base/i7080s.txt
##time0R=`grep 0.02.0 $in_log | tail -n 1 | awk '{print $2}'`
#считываем последнюю строку времени сброса 0го счетчика
time0D=`grep 1.02.0 $in_log | tail -n 1 | awk '{print $2}'`
#считываем последнее значение времени полученных данных 0го счетчика
time0countHex=`grep 1.02.0 $in_log | tail -n 1 | awk '{print $3}' | tr -d '>'`
#считываем значение 0го счетчика в HEX
##time1R=`grep 0.02.1 $in_log | tail -n 1 | awk '{print $2}'`
time1D=`grep 1.02.1 $in_log | tail -n 1 | awk '{print $2}'`
time1countHex=`grep 1.02.1 $in_log | tail -n 1 | awk '{print $3}' | tr -d '>'`
echo "0count:$time0countHex"
#if [[ ${!time0countHex} ]];  then time0count=$((0x$time0countHex)); fi  #convert HEX to DEC#echo $time0count
time0count=$((0x$time0countHex))  #convert HEX to DEC#echo $time0count
echo "1count:$time1countHex"
#if [ -v "${time1countHex}" ]; then  time1count=$((0x$time1countHex)); fi #echo $time1count
time1count=$((0x$time1countHex)) #echo $time1count

#echo "$time0R to $time0D count $time0count($time0countHex)"#echo "$time1R to $time1D count $time1count($time1countHex)"
t01=$(date -d $time0R '+%s') #преобразуем в секунды
t02=$(date -d $time0D '+%s') #
sec0=$((t02-t01)) # получаем разницу в секундах времени подсчета
echo -e "$dtm:\tdata10:\t$t01($time0R)\t$t02($time0D)\t deltaT:$sec0\t counter:$time0count" >> $sp_log
#echo -e "$dtm:\tdata10:\t$t01\t$t02\t deltaT:$sec0\t counter:$time0count" >> $sp_log

#echo 60*$time0count/$sec0 | bc -l >> $dir1/out.txt
t11=$(date -d $time1R '+%s')
t12=$(date -d $time1D '+%s')
sec1=$((t12-t11))
echo -e "$dtm:\tdata11:\t$t11($time1R)\t$t12($time1D)\t deltaT2:$sec1\t counter:$time1count" >> $sp_log
if (( $sec0 > 0 )); then # если промежуток между сбросом и чтение существует
res0=`echo "scale=1;2*60*$time0count/$sec0" | bc -l`
echo -e "Speed0 last cycle = \t $res0 " >> $dir_base/i7080s.txt
fi
echo "test"
if (( $sec1 > 0)); then
#res1=`echo 2*60*$time1count/$sec1 | bc -l`
#с округлением
res1=`echo "scale=1;2*60*$time1count/$sec1" | bc -l`

echo -e "Speed1 last cycle = \t $res1 " >> $dir_base/i7080s.txt
fi
echo "end speed"
############################### reset i7080
fls="$dir_del/i7080.alog"
dtm=`date +"%d%m%y_%H:%M:%S"`
echo "reset7080_$dtm" >> $dirlog
echo -e "\t\n ============BeginCountCycle \t\n" >> $fls;
echo -e "\t\n ======reset_counter_DaTime:$dtm\n\t" >> $fls
#RESULT=$(cat $TTY >> $fls & 
#echo -e '$02M\r' > $TTY; sleep $SLEEP;#идентифицируем модуль
#echo -e '$02M\r' > $TTY; sleep $SLEEP;
#kill %cat)
#echo -e "\n" > $TTY;
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
kill %cat)
dtm=`date +"%d%m%y_%H:%M:%S"`
echo "resetStop7080_$dtm" >> $dirlog
cat $fls >> "$dir_del/7080.lag"

########################## reset port
echo "reserial" >> $dirlog;
echo -e -n "\x00\x00" > /dev/ttyS1;
echo -e -n "\x00\x00" > /dev/ttyS1;



############################ clear
#echo "cleaner" >> $dirlog
#files=`find -P $dir_del -name '*.alog'`
#arr_files=($files)
#for s in "${arr_files[@]}";do
############# готовим для раннего пользования данные ресета 7080
f78a="$dir_del/i7080.alog"
cat $f78a | tr '\r' '\n' > $f78a.txt
sed -i "s/\!027//g" $f78a.txt
sed -i "s/\!02/OK-reset/g" $f78a.txt
cat $f78a.txt | tr '\n' '\t' > $f78a.2.txt
sed -i "s/*\tOK-reset/OK-reset\n/g" $f78a.2.txt # *таб и ОКресет на ОКресет и перевод строки
##sed -i "s/\t\*\t/\t/g" $s.2.txt
sed -i "s/\t\t/\n/g" $f78a.2.txt # два слеша меняем на конец строки
##sed -i "s/\!02/OK-reset/g" $s.txt
sed -i -r '/^.{,7}$/d' $f78a.2.txt # пустые строки короче 7 символовов
sed -i -r 's/^[ \t]*//;s/[ \t]*$//' $f78a.2.txt #в начале лишние табуляции
##sed -i -r "s/\t\/*\t/\t/g" $s.2.txt
##sed -i '/*/d' $s.2.txt #remove lines *
sed -i -r '/^.{,7}$/d' $f78a.txt # пуст строки и короче 7 символов
sed -i -r "s/\t\*\t/\t/g" $f78a.2.txt # delete tab*tab to tab
sed -i '/*/d' $f78a.2.txt #remove lines *
#unlink $s #удаляем исходн.файл
#done
#cp $f78a.2.txt $f78a.reset
cat $f78a.2.txt >> $f78a.reset
#echo "" >> $dir_base/i7080_full.log
#cat $dir_del/i7080.alog.2.txt >> $dir_base/i7080_full.log
##cp $dir_del/i7019.1.txt $dir_base/i7019.txt
#cat $dir_del/i7019.alog.txt >> $dir_base/i7019.txt





######################### kill util
killall cat;
#killall wvdial;
#killall adam.bash
echo "a_datam_Stop" >> $dirlog;
killall a_datam.bash
