CC = arm-elf-gcc
AS = arm-elf-as


ASM.FILES ASM.FILES += cstartup.S


ASM.FLAGS += -gstabs

C.FILES = main.c

C.FLAGS +C.FLAGS += -c
C.FLAGS += -g

L.FLAGS L.FLAGS += -nostartfiles
L.FLAGS += -Wl,-Map=mapfile.map
L.FLAGS += -Wl,--script=my_linker_script
L.FLAGS += -Wl,-cref

OBJ OBJ += $(patsubst %.S,%.o,$(ASM.FILES))
OBJ += $(patsubst %.c,%.o,$(C.FILES))


%.o : %.S  makefile
         $(AS) $(INC) $(ASM.FLAGS) $< -o $@

%.o : %.c  makefile
         $(CC) $(INC) $(C.FLAGS) $< -o $@

all: $(OBJ)

exec: $(OBJ)	
         $(CC) $(L.FLAGS) $(OBJ) -o main.elf
