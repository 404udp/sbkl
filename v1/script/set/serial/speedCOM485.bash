#stty 9600 -F /dev/ttyS0
chmod 666 /dev/ttyS1
#stty 9600 -echo -crtscts -ixon  -F /dev/ttyS1
#stty 9600 min 1 time 5 -echo -crtscts ignbrk -brkint icrnl -imaxbel -opost -onclr -isig -icanon -iexten -echo echok -echoctl -echoke  -F /dev/ttyS1
stty 9600 min 1 time 10 -echo -crtscts ignbrk -brkint icrnl -imaxbel -opost -isig -icanon -iexten -echo echok -echoctl -echoke  -F /dev/ttyS1

#stty 9600 -crtscts  -F /dev/ttyS1

#stty 4800 -F /dev/ttyS2
#sstty 4800 -F /dev/ttyS3
