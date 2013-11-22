
;@-------------------------------------------------------------------------
;@-------------------------------------------------------------------------
;@--- Startup proccess for RazOS, also where simple type conversion
;@--- fuctions will be placed
;@-------------------------------------------------------------------------

.globl _start
;@ Begin with vectors table to hardware interupts
_start:
    ldr pc,reset_handler
    ldr pc,undefined_handler
    ldr pc,swi_handler
    ldr pc,prefetch_handler
    ldr pc,data_handler
    ldr pc,unused_handler
    ldr pc,irq_handler
    ldr pc,fiq_handler
reset_handler:      .word reset
undefined_handler:  .word hang
swi_handler:        .word hang
prefetch_handler:   .word hang
data_handler:       .word hang
unused_handler:     .word hang
irq_handler:        .word irq
fiq_handler:        .word hang



reset:

 ;@Need to clear registers in each CPU mode first
 
 
 hang: 
   b hang
