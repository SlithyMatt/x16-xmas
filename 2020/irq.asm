.ifndef IRQ_INC
IRQ_INC = 1

.include "music.asm"
.include "text.asm"
.include "bitmap.asm"

def_irq: .word $0000

init_irq:
   sei
   lda IRQVec
   sta def_irq
   lda IRQVec+1
   sta def_irq+1
   lda #<handle_irq
   sta IRQVec
   lda #>handle_irq
   sta IRQVec+1
   cli
   rts



handle_irq:
   ; check for VSYNC
   lda VERA_isr
   and #$01
   beq @done_vsync
   lda RAM_BANK
   pha
   jsr music_tick
   jsr text_tick
   jsr bitmap_tick
   pla
   sta RAM_BANK

@done_vsync:

   jmp (def_irq)




.endif
