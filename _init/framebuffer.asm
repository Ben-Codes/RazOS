;@----------------------------------------------
;@----------------------------------------------
;@-- Framebuffer library for RazOS
;@----------------------------------------------
;@ More info can be found here
;@ http://www.cl.cam.ac.uk/projects/raspberrypi/tutorials/os/screen01.html
;@=============================================
;@ Provides basic interface to the mailbox system
;@ Which is what is used to communicate with the GPU
;@=============================================
;@ Notes: May make this a driver in the future
;@	so consider if pointers were virtual addresses


;@ start with the object the GPU will be expecting
.section .bss
.align 4
.globl FrameBufferInfo
FrameBufferInfo:
	.int 1024 ;@ Physical Width #0
	.int 768  ;@ Physical Height #4
	.int 1024 ;@ Virtual Width #8
	.int 768  ;@ Virtual Height #12
	.int 0	  ;@ GPU Pitch #16
	.int 16	  ;@ Bit Depth #20
	.int 0    ;@ X #24
	.int 0 	  ;@ Y #28
	.int 0	  ;@ GPU Pointer #32
	.int 0 	  ;@ GPU Size #36

.section .text
.globl InitialiseFrameBuffer
InitialiseFrameBuffer:
	width .req r0
	height .req r1
	bitDepth .req r2
	cmp width,#4096
	cmpls height,#4096
	cmpls bitDepth,#32
	result .req r0
	movhi result,#0 ;@ we return 0 if out of range
	movhi pc,lr
	
	fbInfoAddr .req r4
	push {r4,lr}
	ldr fbInfoAddr,=FrameBufferInfo
	str width,[fbInfoAddr,#0]
	str height,[fbInfoAddr,#4]
	str width,[fbInfoAddr,#8]
	str height,[fbInfoAddr,#12]
	str height,[fbInfoAddr,#12]
	.unreq width
	.unreq height
	.unreq bitDepth
	
	mov r0,fbInfoAddr
	pop {r4,pc}
