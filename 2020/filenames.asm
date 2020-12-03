.ifndef FILENAMES_INC
FILENAMES_INC = 1

.include "globals.asm"

filenames:
pal1_fn:       .asciiz "pal1.bin"
pal2_fn:       .asciiz "pal2.bin"
pal3_fn:       .asciiz "pal3.bin"
pal4_fn:       .asciiz "pal4.bin"
music_fn:      .asciiz "music.bin"
bm1_fn:        .asciiz "bitmap1.bin"
bm2_fn:        .asciiz "bitmap2.bin"
bm3_fn:        .asciiz "bitmap3.bin"
bm4_fn:        .asciiz "bitmap4.bin"
end_filenames:
FILES_TO_LOAD = 5
bankparams:
.byte PAL1_BANK
.byte pal2_fn-pal1_fn-1
.word pal1_fn
.byte PAL2_BANK
.byte pal3_fn-pal2_fn-1
.word pal2_fn
.byte PAL3_BANK
.byte pal4_fn-pal3_fn-1
.word pal3_fn
.byte PAL4_BANK
.byte music_fn-pal4_fn-1
.word pal4_fn
.byte MUSIC_BANK                ; bank
.byte bm1_fn-music_fn-1         ; filename length
.word music_fn                  ; filename address
.byte BM1_BANK
.byte bm2_fn-bm1_fn-1
.word bm1_fn
.byte BM2_BANK
.byte bm3_fn-bm2_fn-1
.word bm2_fn
.byte BM3_BANK
.byte bm4_fn-bm3_fn-1
.word bm3_fn
.byte BM4_BANK
.byte end_filenames-bm4_fn-1
.word bm4_fn

.endif
