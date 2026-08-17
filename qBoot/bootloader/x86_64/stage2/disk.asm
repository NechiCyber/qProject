bits 16

KERNEL_TEMP_SEGMENT equ 0x2000
KERNEL_TEMP_OFFSET  equ 0x0000

KERNEL_LBA          equ 9
KERNEL_SECTORS      equ 32

load_kernel:

    mov ax, KERNEL_TEMP_SEGMENT
    mov es, ax
    xor bx, bx

    mov si, dap

    mov ah, 0x42
    mov dl, [boot_drive]

    int 0x13
    jc kernel_error

    ret


kernel_error:

    mov si, error_message

.print:
    lodsb

    test al, al
    jz .halt

    mov ah, 0x0E
    int 0x10

    jmp .print

.halt:
    cli
    hlt
    jmp .halt


align 4

dap:
    db 0x10
    db 0

    dw KERNEL_SECTORS

    dw KERNEL_TEMP_OFFSET
    dw KERNEL_TEMP_SEGMENT

    dq KERNEL_LBA


error_message db "qBoot: kernel load error!", 0
