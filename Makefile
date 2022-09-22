.SUFFIXES: .o .c .asm

CFLAGS += -g

.asm.o:
	nasm -f elf64 -g -F DWARF $^ -o $@

all: ejercicio

clean:
	rm -f ejercicio_1.o ejercicio1.o ejercicio

ejercicio: ejercicio_1.o ejercicio1.o
	$(CC) $(LDFLAGS) $^ -o $@

.PHONY: all clean