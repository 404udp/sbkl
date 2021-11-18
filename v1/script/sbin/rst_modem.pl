#!/usr/bin/perl -w
# yum install perl-Device-SerialPort # Fedora
# apt-get install libdevice-serialport-perl # Debian
# ./DTR8X.pl /dev/ttyUSB0 # syntax
use Device::SerialPort;
my $device = '/dev/ttyS0'; # default device
my $milliseconds = 500; # 0.5s delay
my $count = 8;
$device = $ARGV[0] if ($#ARGV == 0); # get device from command line
my $port=new Device::SerialPort($device) || die "new($device): $! ";
for (my $i = 0; $i <= $count; $i++) { $port->pulse_dtr_off($milliseconds); }
