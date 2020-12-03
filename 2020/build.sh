#!/bin/bash

gcc -o vgm2x16opm.exe ../vgm2x16opm.c
gcc -o convbin.exe ../convbin.c
gcc -o pal12bit.exe pal12bit.c
./vgm2x16opm.exe ../JingleBells.vgm MUSIC.BIN A000
./convbin.exe ../sleighride.data BITMAP1.BIN A000
./convbin.exe ../ice_skating.data BITMAP2.BIN A000
./convbin.exe ../sleighstorm.data BITMAP3.BIN A000
./convbin.exe ../santa_kids.data BITMAP4.BIN A000
./pal12bit.exe x16-default.data.pal PAL1.BIN
./pal12bit.exe x16-default.data.pal PAL2.BIN
./pal12bit.exe x16-default.data.pal PAL3.BIN
./pal12bit.exe x16-default.data.pal PAL4.BIN
cl65 --cpu 65C02 -t cx16 -o XMAS2020.PRG -l xmas2020.list xmas2020.asm
