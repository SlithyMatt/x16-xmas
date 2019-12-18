.ifndef VSYNC_INC
VSYNC_INC = 1

.include "music.asm"

vsync_trig: .byte 0

check_vsync:
   lda vsync_trig
   beq @done

   ; VSYNC has occurred, handle
   jsr music_tick
   ; TODO: other tick handlers

   stz vsync_trig
@done:
   rts

.endif
