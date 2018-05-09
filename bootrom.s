	.align 4096
	.text
_rstext:
.incbin "bootrom.bin"
.include "rom-functions.s"


