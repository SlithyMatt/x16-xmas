.ifndef VSYNC_INC
VSYNC_INC = 1

.include "music.asm"
.include "bitmap.asm"
.include "text.asm"

vsync_trig: .byte 0

check_vsync:
   lda vsync_trig
   beq @done

   ; VSYNC has occurred, handle
   jsr music_tick
   jsr bitmap_tick
   jsr text_tick

   stz vsync_trig
@done:
   rts

.endif
