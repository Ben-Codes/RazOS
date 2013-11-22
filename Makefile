###############################################################################
#  makefile
#   influenced by : Alex Chadwick
#   written by: Ben Evans
#
#  A makefile script for generation of raspberry pi kernel images.
###############################################################################

ARMGNU ?= arm-none-eabi

COPS = -Wall -O2 -nostdlib -nostartfiles -ffreestanding 

# The intermediate directory for compiled object files.
BUILD = build/
TARGET = kernel.img
LIST = kernel.list
MAP = kernel.map
LINKER = kernel.ld


gcc : blinker07.hex blinker07.bin

all : gcc 

# Rule to make the object files from C.
$(BUILD)%.o: $(SOURCE)%.c $(BUILD)
	$(ARMGNU)-gcc $(COPS) -c $(SOURCE) $< 0-c $@
	
$(BUILD)%.o: $(SOURCE)%.s $(BUILD)
	$(ARMGNU)-as -I $(SOURCE) $< -o $@
	
$(BUILD)%.elf : linker.ld $(SOURCE)%.s $(BUILD)
        $(ARMGNU)-ld vectors.o blinker07.o -T memmap -o blinker07.elf
        $(ARMGNU)-objdump -D blinker07.elf > blinker07.list
        
clean :
        rm -f *.o
        rm -f *.bin
        rm -f *.hex
        rm -f *.elf
        rm -f *.list
        rm -f *.img
        rm -f *.bc
        rm -f *.clang.opt.s
