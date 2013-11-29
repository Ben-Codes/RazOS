/******************************************************************************
*	frameBuffer.s
*	 by Alex Chadwick
*
*	frameBuffer.s contains code that creates and manipulates the frame buffer.
******************************************************************************/


.section .data
.align 12
.globl FrameBufferInfo 
FrameBufferInfo:
	.int 1024	/* #0 Width */
	.int 768	/* #4 Height */
	.int 1024	/* #8 vWidth */
	.int 768	/* #12 vHeight */
	.int 0		/* #16 GPU - Pitch */
	.int 16		/* #20 Bit Dpeth */
	.int 0		/* #24 X */
	.int 0		/* #28 Y */
	.int 0		/* #32 GPU - Pointer */
	.int 0		/* #36 GPU - Size */

.section .text
.global WritePixel
WritePixel:
	x .req r0
	y .req r1
	value .req r2
	fbInfoAddr .req r5
	
	cmp y,#4096
	cmpls x,#4096
	result .req r0
	movhi result,#0
	movhi pc,lr
	
	push {r3,r4,r5,r6}
	
	ldr fbInfoAddr,=FrameBufferInfo
	ldr r4,[fbInfoAddr,#0]
	mla r6,y,r4,x
	mov r3,#2
	mul r4,r6,r3
	
	address .req r3
	ldr address,[fbInfoAddr,#32]
	add address,r4
	strh value,[address]

	pop {r3,r4,r5,r6}
	mov pc,lr
	.unreq address
	.unreq fbInfoAddr
	.unreq result
	.unreq value
	.unreq x
	.unreq y



.globl InitialiseFrameBuffer
InitialiseFrameBuffer:
	width .req r0
	height .req r1
	bitDepth .req r2
	cmp width,#4096
	cmpls height,#4096
	cmpls bitDepth,#32
	result .req r0
	movhi result,#0
	movhi pc,lr

	push {r4,lr}	
	fbInfoAddr .req r4		
	ldr fbInfoAddr,=FrameBufferInfo
	str width,[r4,#0]
	str height,[r4,#4]
	str width,[r4,#8]
	str height,[r4,#12]
	str bitDepth,[r4,#20]
	.unreq width
	.unreq height
	.unreq bitDepth

	mov r0,fbInfoAddr
	add r0,#0x40000000
	mov r1,#1
	bl MailboxWrite
	
	mov r0,#1
	bl MailboxRead
		
	teq result,#0
	movne result,#0
	popne {r4,pc}

	mov result,fbInfoAddr
	pop {r4,pc}
	.unreq result
	.unreq fbInfoAddr
	

