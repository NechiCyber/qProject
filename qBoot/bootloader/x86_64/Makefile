ASM = nasm
QEMU = qemu-system-x86_64

QOS = ../../../qOS

STAGE1 = stage1/boot.asm
STAGE2 = stage2/main.asm

all: qboot.img

stage1.bin: $(STAGE1)
	$(ASM) -f bin $< -o $@

stage2.bin: $(STAGE2) stage2/gdt.asm stage2/paging.asm stage2/longmode.asm stage2/disk.asm stage2/kernel.asm
	$(ASM) -f bin -Istage2/ $< -o $@

qos:
	$(MAKE) -C $(QOS)

qboot.img: stage1.bin stage2.bin qos
	cat stage1.bin stage2.bin $(QOS)/build/kernel.bin > qboot.img
	truncate -s 256K qboot.img

run: qboot.img
	$(QEMU) -drive format=raw,file=qboot.img

clean:
	rm -f stage1.bin stage2.bin qboot.img
	$(MAKE) -C $(QOS) clean
