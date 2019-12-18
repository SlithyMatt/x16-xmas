.ifndef FILENAMES_INC
FILENAMES_INC = 1

.include "globals.asm"

filenames:
music_fn:      .asciiz "music.bin"
bm1_fn:        .asciiz "bitmap1.bin"
bm2_fn:        .asciiz "bitmap2.bin"
bm3_fn:        .asciiz "bitmap3.bin"
bm4_fn:        .asciiz "bitmap4.bin"
end_filenames:
FILES_TO_LOAD = 5
bankparams:
.byte MUSIC_BANK                ; bank
.byte bm1_fn-music_fn-1         ; filename length
.word music_fn                  ; filename address
.byte BM1_BANK
.byte bm2_fn-bm1_fn
.word bm1_fn
.byte BM2_BANK
.byte bm3_fn-bm2_fn
.word bm2_fn
.byte BM3_BANK
.byte bm4_fn-bm3_fn
.word bm3_fn
.byte BM4_BANK
.byte end_filenames-bm4_fn
.word bm4_fn

.endif
