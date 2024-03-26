# Makefile for assembling ASM files with NASM and linking with ld 

# Usage: make FILE=ex01/ex01.asm

# Extract the directory and the base name of the provided file
DIR := $(dir $(FILE))
BASENAME := $(notdir $(FILE:.asm=))

# Name of the final executable
EXECUTABLE := $(DIR)$(BASENAME)

# Assembler and flags
ASM := nasm
ASMFLAGS := -f elf32

# Linker and flags
LD := ld
LDFLAGS := -m elf_i386

# Rule to assemble the ASM file into an object file and link it into the final executable
$(EXECUTABLE): $(FILE)
	$(ASM) $(ASMFLAGS) $< -o $(DIR)$(BASENAME).o
	$(LD) $(LDFLAGS) $(DIR)$(BASENAME).o -o $@

# Clean rule to remove generated files
#clean:
#	rm -f $(DIR)$(BASENAME).o $(EXECUTABLE)

# Phony targets
#.PHONY: clean
