#!/bin/bash

bdir="/sbkl/script/set/serial"

bash $bdir/ramdisk.sh
bash $bdir/speedCOM485.bash
bash $bdir/speedCOM.bash
bash $bdir/speedUSB.bash
bash $bdir/swapoff.bash
bash $bdir/adam_start.bash