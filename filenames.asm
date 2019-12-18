.ifndef FILENAMES_INC
FILENAMES_INC = 1

.include "globals.asm"

filenames:
music_fn:      .asciiz "music.bin"
bm1_fn:        .asciiz "bitmap1.bin"
end_filenames:
FILES_TO_LOAD = 2
bankparams:
.byte MUSIC_BANK                ; bank
.byte bm1_fn-music_fn-1         ; filename length
.word music_fn                  ; filename address
.byte BM1_BANK
.byte end_filenames-bm1_fn
.word bm1_fn

.endif
