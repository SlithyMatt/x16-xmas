.include "x16.inc"

.org $080D
.segment "STARTUP"
.segment "INIT"
.segment "ONCE"
.segment "CODE"
   jmp start

.include "filenames.asm"
.include "loadbank.asm"
.include "irq.asm"
.include "globals.asm"

.macro PRINT_STRING str_arg
   .scope
         jmp end_string
      string_begin: .byte str_arg
      end_string:
         lda #<string_begin
         sta ZP_PTR_1
         lda #>string_begin
         sta ZP_PTR_1+1
         ldx #(end_string-string_begin)
         ldy #0
      loop:
         lda (ZP_PTR_1),y
         jsr CHROUT
         iny
         dex
         bne loop
   .endscope
.endmacro

.macro PRINT_CR
   lda #$0D
   jsr CHROUT
.endmacro

start:

   ; Disable layers and sprites
   lda VERA_dc_video
   and #$8F
   sta VERA_dc_video

   ; relocate PETSCII characters to end of VRAM
   stz VERA_ctrl
   VERA_SET_ADDR VRAM_petscii, 1
   lda #1
   sta VERA_ctrl
   VERA_SET_ADDR VRAM_CHARACTER_SET, 1
   ldx #0
   ldy #2
@copy_loop:
   lda VERA_data0
   sta VERA_data1
   dex
   bne @copy_loop
   dey
   bne @copy_loop

   ; clear text map
   stz VERA_ctrl
   VERA_SET_ADDR VRAM_TEXT, 2
   ldx #$00
   ldy #$40
@clear_loop:
   lda #$20 ; space
   sta VERA_data0
   dex
   bne @clear_loop
   dey
   bne @clear_loop

   ; Setup 256-color text on layer 1
   lda #$68                      ; 128x64 256-color text
   sta VERA_L1_config
   lda #((VRAM_TEXT >> 9) & $FF)
   sta VERA_L1_mapbase
   lda #((((VRAM_CHARACTER_SET >> 11) & $3F) << 2) | $00)  ; relocated PETSCII
   sta VERA_L1_tilebase
   stz VERA_L1_hscroll_l         ; set scroll position to 0,0
   stz VERA_L1_hscroll_h
   stz VERA_L1_vscroll_l
   stz VERA_L1_vscroll_h

   ; Initialize text
   jsr init_text

   ; set display to 2x scale
   lda #64
   sta VERA_dc_hscale
   sta VERA_dc_vscale

   ; store binaries to banked RAM
   jsr loadbank

   ; configure layer 0 for background bitmaps
   lda #$07      ; 8bpp bitmap
   sta VERA_L0_config
   lda #((((VRAM_BITMAP >> 11) & $3F) << 2) | $00) ; 320x240
   sta VERA_L0_tilebase

   ; enable all layers
   lda VERA_dc_video
   ora #$30
   sta VERA_dc_video

   ; setup interrupts
   jsr init_irq

mainloop:
   wai
   lda change_trig
   beq mainloop
   jsr change_bitmap
   stz change_trig
   bra mainloop  ; loop forever
