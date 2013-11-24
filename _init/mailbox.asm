;@----------------------------------------------
;@----------------------------------------------
;@-- Mailbox library for RazOS
;@----------------------------------------------
;@ More info can be found here
;@ http://www.cl.cam.ac.uk/projects/raspberrypi/tutorials/os/screen01.html
;@=============================================
;@ Provides basic interface to the mailbox system
;@ Which is what is used to communicate with the GPU
;@=============================================
;@ Notes: May make this a driver in the future
;@	so consider if pointers were virtual addresses

;@Loads base address to the mailbox into mem
.globl MailboxBase
MailboxBase:
	ldr r0,=0x2000B880
	mov pc,lr
	

	
;@Writes data into mailbox
;@r0 is the message to send, 32 bits wide, first 4 must be 0000 
;@r1 is the address, limited to 4 bits wide
.globl MailboxWrite
MailboxWrite:
	tst r0,#0b1111
	movne pc,lr		;@ if the first four bits are not 0 return out
	cmp r1,#15
	movhi pc,lr		;@ if r1 has a value greater than 4bits no good
	
	channel .req r1
	value .req r2
	mov value,r0	;@ move the value out of r0, we are about to use it
	push {lr}
	bl =MailboxBase	;@ Put the addressbase into r0
	mailbox .req r0
	
writepolling$:
	status .req r3
	ldr status, [mailbox,#0x18] ;@ move up to the status reg and store it
	
	tst status,#0x80000000	;@checking top bit to see if its 1
	.unreq status
	bne writepolling$	;@ top bit wasnt 1 lets keep polling
	
	add value,channel ;@ merge the 4 bits of the channel to the value
	.unreq channel
	
	str value,[mailbox,#0x20] ;@store the value into the send slot
	.unreq value
	.unreq mailbox
	pop {pc}

;@ Reads specified mailbox
;@ r0 is the channel to read
.globl MailboxRead
MailboxRead:
	cmp r0,#15	;@ make sure our value is only
	movhi pc,lr
	
	channel .req r1
	mov channel,r0 ;@ move our value out of r0 into our channel
	push {lr}
	bl =MailboxBase
	mailbox .req r0
	
rightmail$:
readpolling$:
	status .req r2
	ldr status,[mailbox,#0x18] ;@ Load register with status
	tst status, #0x40000000
	.unreq status
	bne readpolling$
	
	mail .req r2
	ldr mail,[mailbox,#0] ;@ Load mail into mailbox register
	
	inchan .req r3
	and inchan,mail,#0b1111	;@ remove the top 28 bits and store in inchan
	teq inchan,channel		;@ test those 4bits to see if its the right channel
	.unreq inchan
	bne rightmail$
	.unreq mailbox
	.unreq channel
	
	and r0,mail,#0xfffffff0
	.unreq mail
	pop {pc}
	
