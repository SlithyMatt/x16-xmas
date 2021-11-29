#!/bin/bash

gcc -o vgm2x16opm.exe ../vgm2x16opm.c
gcc -o convbin.exe ../convbin.c
gcc -o pal12bit.exe pal12bit.c
./vgm2x16opm.exe BellsCarol.vgm MUSIC.BIN A000
./convbin.exe bells.data BITMAP1.BIN A000
./convbin.exe log.data BITMAP2.BIN A000
./convbin.exe santa.data BITMAP3.BIN A000
./convbin.exe sled.data BITMAP4.BIN A000
./pal12bit.exe bells.data.pal PAL1.BIN
./pal12bit.exe log.data.pal PAL2.BIN
./pal12bit.exe santa.data.pal PAL3.BIN
./pal12bit.exe sled.data.pal PAL4.BIN
cl65 --cpu 65C02 -t cx16 -o XMAS2021.PRG -l xmas2021.list xmas2021.asm
