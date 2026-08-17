bits 32

KERNEL_TEMP equ 0x20000
KERNEL_DEST equ 0x100000

KERNEL_SIZE equ 16384

load_kernel_to_memory:

    mov esi, KERNEL_TEMP
    mov edi, KERNEL_DEST

    mov ecx, KERNEL_SIZE / 4

    cld
    rep movsd

    ret
