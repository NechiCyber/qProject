bits 16
org 0x7c00

STAGE2_SEGMENT equ 0x0000
STAGE2_OFFSET equ 0x8000
STAGE2_SECTORS equ 8

start:
    cli

    mov [boot_drive], dl

    mov ax, STAGE2_SEGMENT
    mov es, ax
    mov bx, STAGE2_OFFSET

    mov ah, 0x02
    mov al, STAGE2_SECTORS
    mov ch, 0
    mov cl, 2
    mov dh, 0
    mov dl, [boot_drive]

    int 0x13

    jc disk_error

    jmp STAGE2_SEGMENT:STAGE2_OFFSET

disk_error:
    mov si, err_msg

.print:
    lodsb

    test al, al
    jz .halt

    mov ah, 0x0e
    int 0x10

    jmp .print

.halt:
    cli
    hlt
    jmp .halt

boot_drive db 0

err_msg db "qBoot: disk read error!", 0

times 510 - ( $ - $$) db 0
dw 0xAA55
