.ifndef BITMAP_INC
BITMAP_INC = 1

.include "x16.inc"
.include "loadbank.asm"

BITMAP_CHANGE_PERIOD = 1080
NUM_BITMAPS = 4
FULL_BANKS_PER_BITMAP = 9
LAST_BITMAP_BANK_END_OFFSET = $C00

__bitmap_change_ticks: .word 0
__bitmap_idx: .byte 3
__bitmap_banks: .byte BM1_BANK, BM2_BANK, BM3_BANK, BM4_BANK
__bitmap_last_bank: .byte 0

bitmap_tick:
   lda __bitmap_change_ticks
   bne @decrement
   lda __bitmap_change_ticks+1
   beq @change
@decrement:
   sec
   lda __bitmap_change_ticks
   sbc #1
   sta __bitmap_change_ticks
   lda __bitmap_change_ticks+1
   sbc #0
   sta __bitmap_change_ticks+1
   jmp @return
@change:
   lda #<BITMAP_CHANGE_PERIOD
   sta __bitmap_change_ticks
   lda #>BITMAP_CHANGE_PERIOD
   sta __bitmap_change_ticks+1
   inc __bitmap_idx
   lda __bitmap_idx
   cmp #NUM_BITMAPS
   bne @load
   stz __bitmap_idx
@load:
   stz VERA_ctrl
   VERA_SET_ADDR VRAM_BITMAP, 1
   ldx __bitmap_idx
   lda __bitmap_banks,x
   clc
   adc #FULL_BANKS_PER_BITMAP
   sta __bitmap_last_bank
   lda __bitmap_banks,x
@loop:
   ldx #0
   ldy #0
   pha
   jsr bank2vram
   pla
   inc
   cmp __bitmap_last_bank
   bmi @loop
   ldx #0
   ldy #(LAST_BITMAP_BANK_END_OFFSET>>5)
   jsr bank2vram
@return:
   rts


.endif
