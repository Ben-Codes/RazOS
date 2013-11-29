
.section .data
.align 4
font:
	.incbin "font.bin"
	

.section .text
.global GetCharAddress
GetCharAddress:
	asciiValue .req r0
	cmp r0,#127
	movhi r0,#0
	movhi pc,lr
	
	push {r1,lr}
	charAddr .req r1
	ldr charAddr,=font
	add charAddr, r0,lsl #4
	
	mov r0,r1
	pop {r1,pc}
	.unreq asciiValue
	.unreq charAddr
