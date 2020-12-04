#!/bin/bash

gcc -o vgm2x16opm.exe ../vgm2x16opm.c
gcc -o convbin.exe ../convbin.c
gcc -o pal12bit.exe pal12bit.c
./vgm2x16opm.exe DeckTheHalls.vgm MUSIC.BIN A000
./convbin.exe rockinghorse.data BITMAP1.BIN A000
./convbin.exe holly.data BITMAP2.BIN A000
./convbin.exe snowman.data BITMAP3.BIN A000
./convbin.exe santa.data BITMAP4.BIN A000
./pal12bit.exe rockinghorse.data.pal PAL1.BIN
./pal12bit.exe holly.data.pal PAL2.BIN
./pal12bit.exe snowman.data.pal PAL3.BIN
./pal12bit.exe santa.data.pal PAL4.BIN
cl65 --cpu 65C02 -t cx16 -o XMAS2020.PRG -l xmas2020.list xmas2020.asm
