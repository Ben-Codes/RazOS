RazOS
=====

An experimental Operating System for Raspberry Pi
=====================================================

Current State - Hardware Discovery and planning
===============================

So I'm currently still gathering as much information as I can on the Raspberry Pi hardware itself. It has been surprisingly difficult to locate registers and bootloader information since the official datasheet is closed but here is where I'm currently at.

IRQ:
The pi bootloader expects the interrupt vector table to appear at 0x80000, which also happens to be where the bootloader directs the PC after its complete.

MMU Table:





Ref Docs
ARM LD: http://www.gnuarm.com/pdf/ld.pdf
PI Perfs Doc: http://www.raspberrypi.org/wp-content/uploads/2012/02/BCM2835-ARM-Peripherals.pdf

