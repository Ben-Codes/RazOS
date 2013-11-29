###############################################################################
#	makefile
#	Created by Ben Evans
#	Special Thanks to Alex Chadwick & David Welch
#
#	A makefile script for creating the test kernal, verfiying hardware quirks
#	TODO: automate script items kinda dookie now
###############################################################################

ARMGNU ?= arm-none-eabi

CSOURCES = kernal_init.c

BUILD = build/

TARGET = kernel.img

MAP = kernel.map

LINKER = linker.ld

CCMDS = -Wall -O2 -nostdlib -nostartfiles -ffreestanding -Wstrict-prototypes

LIST = kernel.list

# The names of all object files that must be generated. Deduced from the 
# assembly code files in source.
ASM_OBJECTS := $(patsubst %.asm,$(BUILD)%.o,$(wildcard *.asm))

# The names of all object files that must be generated. Deduced from the 
# assembly code files in source.
C_OBJECTS := $(patsubst %.c,$(BUILD)%.o,$(wildcard *.c))

# Rule to make everything.
all: $(TARGET) $(LIST)

# Rule to remake everything. Does not include clean.
rebuild: all

$(BUILD):
	mkdir $@
	
# Rule to make the object files.
$(BUILD)%.o: %.asm $(BUILD)
	$(ARMGNU)-as $< -o $@
	
$(BUILD)%.o: %.c $(BUILD)
	$(ARMGNU)-gcc $(CCMDS) -c $< -o $@
	
# Rule to make the elf file.
$(BUILD)output.elf : $(ASM_OBJECTS) $(C_OBJECTS) $(LINKER)
	$(ARMGNU)-ld --no-undefined $(ASM_OBJECTS) $(C_OBJECTS) -Map $(MAP) -o $(BUILD)output.elf -T $(LINKER)
	
# Rule to make the image file.
$(TARGET) : $(BUILD)output.elf
	$(ARMGNU)-objcopy $(BUILD)output.elf -O binary $(TARGET)

# Rule to make the hex file.
$(BUILD)output.hex : $(BUILD)output.elf
	$(ARMGNU)-objcopy $(BUILD)output.elf -O ihex $(BUILD)output.hex

# Rule to make the listing file.
$(LIST) : $(BUILD)output.elf
	$(ARMGNU)-objdump -d $(BUILD)output.elf > $(LIST)

$(BUILD):
	mkdir $@

# Rule to clean files.
clean : 
	-rm -rf $(BUILD)
	-rm -f $(TARGET)
	-rm -f $(LIST)
	-rm -f $(MAP)
