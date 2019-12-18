.ifndef X16_INC
X16_INC  = 1

__CX16__ = 1

; RAM Addresses

; Kernal Registers
JOY1					= $02BC
JOY2					= $02BF

; Zero-Page userspace
ZP_PTR_1 = $00
ZP_PTR_2 = $02
ZP_PTR_3 = $04
ZP_PTR_4 = $06

; I/O Registers
VERA_addr_low     = $9F20
VERA_addr_high    = $9F21
VERA_addr_bank    = $9F22
VERA_data0        = $9F23
VERA_data1        = $9F24
VERA_ctrl         = $9F25
VERA_irq_ctrl     = $9F26
VERA_irq          = $9F27

ROM_BANK          = $9F60
RAM_BANK          = $9F61

YM_reg         	= $9FE0
YM_data        	= $9FE1

; Emulator Registers
GIF_ctrl          = $9FB5

; Banked Addresses
RAM_WIN           = $A000
RAM_WIN_SIZE      = $2000
ROM_WIN           = $C000

; Kernal Subroutines
GETJOY			:= $FF06
MOUSE				:= $FF09
SETLFS   		:= $FFBA
SETNAM   		:= $FFBD
LOAD     		:= $FFD5


; VRAM Addresses

VRAM_composer  = $F0000
VRAM_hscale    = VRAM_composer+1
VRAM_vscale    = VRAM_composer+2
VRAM_palette   = $F1000
VRAM_layer0    = $F2000
VRAM_layer1    = $F3000
VRAM_sprreg    = $F4000
VRAM_sprattr   = $F5000
VRAM_audio     = $F6000
VRAM_spi       = $F7000
VRAM_uart      = $F8000

VROM_petscii   = $1F000

; IRQs
IRQVec         := $0314
BRKVec         := $0316
NMIVec         := $0318

;   Macros

.macro VERA_SET_ADDR addr, stride
	.ifnblank stride
		lda #((^addr) | (stride << 4))
	.else
		lda #(^addr) | $10
	.endif

	sta VERA_addr_bank
	lda #(>addr)
	sta VERA_addr_high
	lda #(<addr)
	sta VERA_addr_low
.endmacro


.endif