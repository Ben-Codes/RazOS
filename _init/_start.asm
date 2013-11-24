;@----------------------------------------------
;@----------------------------------------------
;@-- Startup proccess for RazOS
;@----------------------------------------------

;@ This tells the linker that it should be first
;@ Credit for vector table info goes to David Welch
;@ github.com/dwelch67/raspberrypi
;@=============================================


.global _start
_start:
	;@ We start by declaring out interupt vector table
	ldr pc,reset_handler
	ldr pc,undefined_handler
	ldr pc,swi_handler
	ldr pc,prefetch_handler
	ldr pc,data_handler
	ldr pc,unused_handler
	ldr pc,irq_handler
	ldr pc,fiq_handler
	
reset_handler:		.word reset
undefined_handler:	.word hang
swi_handler:		.word hang
prefetch_handler:	.word hang
data_handler:		.word hang
unused_handler:		.word hang
irq_handler:		.word irq
fiq_handler:		.word hang


;@ We must first copy the vector table to 0x0000
;@ where the PI is expecting it to be
reset:
	mov r0,#0x8000
	mov r1,#0x0000
	ldmia r0!,{r2,r3,r4,r5,r6,r7,r8,r9}
	stmia r1!,{r2,r3,r4,r5,r6,r7,r8,r9}
	ldmia r0!,{r2,r3,r4,r5,r6,r7,r8,r9}
	stmia r1!,{r2,r3,r4,r5,r6,r7,r8,r9}
	
	bl kernal_init
	
hang: b hang

	
.global GET32
GET32:
	ldr r0,[r0]
	bx lr
	
.global PUT32
PUT32:
	str r1,[r0]
	bx lr

irq:
	push {r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,lr}
	bl irq_event_handler 
	pop {r0,r1,r2,r3,r4,r5,r6,r7,r8,r9,r10,r11,r12,lr}
	subs pc,lr,#4
	
	
	
