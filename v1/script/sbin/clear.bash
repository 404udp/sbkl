#!/bin/bash

dir_b="/sbkl/del"

cat $dir_b/i7080.alog.reset | tail -n 33 > $dir_b/reset.tmp
cp $dir_b/reset.tmp $dir_b/i7080.alog.reset
