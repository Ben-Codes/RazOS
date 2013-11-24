###############################################################################
#	makefile
#	Created by Ben Evans
#	Special Thanks to Alex Chadwick & David Welch
#
#	A makefile script for creating the test kernal, verfiying hardware quirks
###############################################################################

ARMGNU ?= arm-none-eabi

CSOURCES = kernal_init.c

BUILD = build/

TARGET = kernel.img

MAP = kernel.map

LINKER = linker.ld

CCMDS = -Wall -O2 -nostdlib -nostartfiles -ffreestanding

gcc : $(TARGET) $(BUILD)output.hex

all : gcc

$(BUILD):
	mkdir $@

clean :
	rm -f *.o
	rm -f *.bin
	rm -f *.hex
	rm -f *.elf
	rm -f *.list
	rm -f *.bc
	rm -f *.clange.opt.s
	
$(BUILD)start.o : _start.s
	$(ARMGNU)-as _start.s -o $(BUILD)start.o
	
$(BUILD)kernal_init.o : kernal_init.c
	$(ARMGNU)-gcc $(CCMDS) -c kernal_init.c -o $(BUILD)kernal_init.o
	
$(BUILD)output.elf : $(BUILD)kernal_init.o $(BUILD)start.o $(LINKER)
	$(ARMGNU)-ld --no-undefined $(BUILD)kernal_init.o $(BUILD)start.o -Map $(MAP) -o $(BUILD)output.elf -T $(LINKER)
	
# Rule to make the image file.
$(TARGET) : $(BUILD)output.elf
	$(ARMGNU)-objcopy $(BUILD)output.elf -O binary $(TARGET)
	
$(BUILD)output.hex : $(BUILD)output.elf
	$(ARMGNU)-objcopy $(BUILD)output.elf -O ihex $(BUILD)output.hex
	



