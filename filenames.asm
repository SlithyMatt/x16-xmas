.ifndef FILENAMES_INC
FILENAMES_INC = 1

.include "globals.asm"

filenames:
bm1_filename:  .asciiz "bitmap1.bin"   ; TODO: move after music
music_fn:      .asciiz "music.bin"
end_filenames:
FILES_TO_LOAD = 3
bankparams:
.byte MUSIC_BANK                ; bank
.byte end_filenames-music_fn-1  ; filename length
.word music_fn                  ; filename address

.endif
