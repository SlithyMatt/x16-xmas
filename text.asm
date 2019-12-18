.ifndef TEXT_INC
TEXT_INC = 1

TEXT_LINE1_VRAM = $01A00
TEXT_LINE2_VRAM = $01B00
TEXT_LINE3_VRAM = $01c00
TEXT_LINE4_VRAM = $01D00

.charmap $40, $00
.charmap $41, $01
.charmap $42, $02
.charmap $43, $03
.charmap $44, $04
.charmap $45, $05
.charmap $46, $06
.charmap $47, $07
.charmap $48, $08
.charmap $49, $09
.charmap $4a, $0a
.charmap $4b, $0b
.charmap $4c, $0c
.charmap $4d, $0d
.charmap $4e, $0e
.charmap $4f, $0f
.charmap $50, $10
.charmap $51, $11
.charmap $52, $12
.charmap $53, $13
.charmap $54, $14
.charmap $55, $15
.charmap $56, $16
.charmap $57, $17
.charmap $58, $18
.charmap $59, $19
.charmap $5a, $1a
.charmap $5b, $1b
.charmap $5c, $1c
.charmap $5d, $1d
.charmap $5e, $1e
.charmap $5f, $1f

__text_line1:
.byte " MERRY CHRISTMAS!                                                                         HAPPY NEW YEAR 2020!                  "
__text_line2:
.byte "                     HAPPY HOLIDAYS!                                                                             PEACE ON EARTH "
__text_line3:
.byte "                                        ALL I WANT FOR CHRISTMAS 2020 IS A COMMANDER X16                                        "
__text_line4:
.byte "                                                                                           YES, THIS IS THE DEFAULT X16 PALETTE!"

TEXT_LINE1_COLOR = $3B
TEXT_LINE2_COLOR = $8E
TEXT_LINE3_COLOR = $1C
TEXT_LINE4_COLOR = $50

TEXT_TICKS_TO_MOVE = 3

__text_scroll: .word 0
__text_move_tick: .byte 0

init_text:
   stz VERA_ctrl
   VERA_SET_ADDR TEXT_LINE1_VRAM, 1
   ldx #0
@loop1:
   lda __text_line1,x
   sta VERA_data0
   lda #TEXT_LINE1_COLOR
   sta VERA_data0
   inx
   cpx #128
   bmi @loop1
   VERA_SET_ADDR TEXT_LINE2_VRAM, 1
   ldx #0
@loop2:
   lda __text_line2,x
   sta VERA_data0
   lda #TEXT_LINE2_COLOR
   sta VERA_data0
   inx
   cpx #128
   bmi @loop2
   VERA_SET_ADDR TEXT_LINE3_VRAM, 1
   ldx #0
@loop3:
   lda __text_line3,x
   sta VERA_data0
   lda #TEXT_LINE3_COLOR
   sta VERA_data0
   inx
   cpx #128
   bmi @loop3
   VERA_SET_ADDR TEXT_LINE4_VRAM, 1
   ldx #0
@loop4:
   lda __text_line4,x
   sta VERA_data0
   lda #TEXT_LINE4_COLOR
   sta VERA_data0
   inx
   cpx #128
   bmi @loop4
   rts

text_tick:
   inc __text_move_tick
   lda __text_move_tick
   cmp #TEXT_TICKS_TO_MOVE
   bne @return
   stz __text_move_tick
   lda __text_scroll
   clc
   adc #1
   sta __text_scroll
   lda __text_scroll+1
   adc #0
   sta __text_scroll+1
   stz VERA_ctrl
   VERA_SET_ADDR VRAM_layer1, 1
   lda VERA_data0 ; ignore first 6
   lda VERA_data0
   lda VERA_data0
   lda VERA_data0
   lda VERA_data0
   lda VERA_data0
   lda __text_scroll
   sta VERA_data0
   lda __text_scroll+1
   sta VERA_data0
@return:
   rts

.endif
