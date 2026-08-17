bits 16
org 0x8000

start:
    cli
    cld

    xor ax, ax
    mov ds, ax
    mov es, ax
    mov ss, ax

    ; Сохраняем номер загрузочного диска
    mov [boot_drive], dl

    ; Загружаем kernel во временную область
    call load_kernel

    ; Загружаем GDT
    lgdt [gdt_descriptor]

    ; Protected Mode
    mov eax, cr0
    or eax, 1
    mov cr0, eax

    jmp CODE32:protected_mode


bits 32

protected_mode:

    mov ax, DATA32
    mov ds, ax
    mov es, ax
    mov ss, ax

    ; Копируем kernel:
    ; 0x20000 -> 0x100000
    call load_kernel_to_memory

    ; Настраиваем paging
    %include "paging.asm"

    ; Переход в Long Mode
    %include "longmode.asm"


bits 64

long_mode:

    mov ax, DATA64
    mov ds, ax
    mov es, ax
    mov ss, ax

    ; Stack
    mov rsp, 0x70000

    ; Запускаем qOS
    mov rax, 0x100000
    jmp rax


bits 16

boot_drive db 0

%include "gdt.asm"
%include "disk.asm"


bits 32

%include "kernel.asm"


times 8 * 512 - ($ - $$) db 0
