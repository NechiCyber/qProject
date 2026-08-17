CC = gcc
LD = ld
ASM = nasm
OBJCOPY = objcopy

CFLAGS = -ffreestanding -fno-pie -fno-stack-protector -mno-red-zone -m64 -Iinclude
LDFLAGS = -T linker.ld -nostdlib

BUILD = build

KERNEL_OBJECTS = \
	$(BUILD)/main.o \
	$(BUILD)/print.o \
	$(BUILD)/terminal.o

all: $(BUILD)/kernel.bin


$(BUILD):
	mkdir -p $(BUILD)


$(BUILD)/entry.o: kernel/entry.asm | $(BUILD)
	$(ASM) -f elf64 kernel/entry.asm -o $@


$(BUILD)/main.o: kernel/main.c | $(BUILD)
	$(CC) $(CFLAGS) -c $< -o $@


$(BUILD)/print.o: kernel/print.c | $(BUILD)
	$(CC) $(CFLAGS) -c $< -o $@

$(BUILD)/terminal.o: kernel/terminal.c | $(BUILD)
	$(CC) $(CFLAGS) -c $< -o $@


$(BUILD)/kernel.elf: $(BUILD)/entry.o $(KERNEL_OBJECTS)
	$(LD) $(LDFLAGS) -o $@ \
		$(BUILD)/entry.o \
		$(KERNEL_OBJECTS)


$(BUILD)/kernel.bin: $(BUILD)/kernel.elf
	$(OBJCOPY) -O binary $< $@


clean:
	rm -rf $(BUILD)