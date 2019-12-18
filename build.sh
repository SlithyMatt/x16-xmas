#!/bin/bash

gcc -o vgm2x16opm.exe vgm2x16opm.c
./vgm2x16opm.exe JingleBells.vgm MUSIC.BIN A000
cl65 --cpu 65C02 -o XMAS2019.PRG -l xmas2019.list xmas2019.asm
