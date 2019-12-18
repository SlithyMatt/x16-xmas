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
.include "music.asm"
.include "text.asm"

charset: .word 0

start:

   stz VERA_ctrl
   VERA_SET_ADDR VRAM_layer1, 1  ; configure VRAM layer 1
   lda VERA_data0 ; ignore
   lda VERA_data0 ; ignore
   lda VERA_data0 ; ignore
   lda VERA_data0 ; ignore
   lda VERA_data0
   sta charset
   lda VERA_data0
   sta charset+1

   stz VERA_ctrl
   lda charset+1
   lsr
   lsr
   lsr
   lsr
   lsr
   lsr
   ora #$10
   sta VERA_addr_bank
   lda charset+1
   asl
   asl
   sta VERA_addr_high
   lda charset
   asl
   asl
   sta VERA_addr_low
   lda #1
   sta VERA_ctrl
   VERA_SET_ADDR VRAM_CHARACTER_SET, 1
   ldx #$00
   ldy #$08
@charloop:
   lda VERA_data0
   sta VERA_data1
   txa
   sec
   sbc #1
   tax
   tya
   sbc #0
   tay
   bne @charloop
   txa
   bne @charloop


   stz VERA_ctrl
   VERA_SET_ADDR VRAM_layer1, 1  ; configure VRAM layer 1
   lda #$21
   sta VERA_data0 ; 256-color text
   lda #$06
   sta VERA_data0 ; 128x64
   lda #<(VRAM_TEXT>>2)
   sta VERA_data0
   lda #>(VRAM_TEXT>>2)
   sta VERA_data0
   lda #<(VRAM_CHARACTER_SET>>2)
   sta VERA_data0
   lda #>(VRAM_CHARACTER_SET>>2)
   sta VERA_data0
   stz VERA_data0
   stz VERA_data0
   stz VERA_data0
   stz VERA_data0

   stz VERA_ctrl
   VERA_SET_ADDR VRAM_TEXT, 1
   ldx #0
   ldy #$20
@loop:
   stz VERA_data0
   txa
   sec
   sbc #1
   tax
   tya
   sbc #0
   tay
   cpx #0
   bne @loop
   cpy #0
   bne @loop



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
   stz VERA_data0
   stz VERA_data0
   stz VERA_data0

   ; setup interrupts
   jsr init_irq

   ; initialize music engine
   jsr init_music

   ; initialize text scroll
   jsr init_text

mainloop:
   wai
   jsr check_vsync
   bra mainloop  ; loop forever
