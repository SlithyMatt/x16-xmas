.include "x16.inc"

.org $080D
.segment "STARTUP"
.segment "INIT"
.segment "ONCE"
.segment "CODE"
   jmp start

.include "loadbank.asm"
.include "irq.asm"
.include "vsync.asm"
.include "globals.asm"

start:

   stz VERA_ctrl
   VERA_SET_ADDR VRAM_layer1, 1  ; configure VRAM layer 1
   lda #$21
   sta VERA_data0 ; 256-color text

   ; TODO clear text

   VERA_SET_ADDR VRAM_hscale, 1  ; set display to 2x scale
   lda #64
   sta VERA_data0
   sta VERA_data0

   ; store binaries to banked RAM
   jsr loadbank

   ; configure layer 0 for background bitmap
   stz VERA_ctrl
   VERA_SET_ADDR VRAM_layer0, 1  ; configure VRAM layer 0
   lda #$E1
   sta VERA_data0 ; 8bpp bitmap
   stz VERA_data0 ; 320x240
   stz VERA_data0
   stz VERA_data0
   lda #<(VRAM_BITMAP >> 2)
   sta VERA_data0
   lda #>(VRAM_BITMAP >> 2)
   sta VERA_data0
   stz VERA_data0
   lda #8
   sta VERA_data0 ; Palette offset = 8
   stz VERA_data0
   stz VERA_data0

   ; setup interrupts
   jsr init_irq

   ; initialize music engine
   jsr init_music

mainloop:
   wai
   jsr check_vsync
   bra mainloop  ; loop forever
