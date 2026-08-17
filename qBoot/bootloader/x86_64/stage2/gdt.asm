bits 16

gdt_start:

    dq 0


gdt_code32:
    dw 0xFFFF
    dw 0
    db 0
    db 10011010b
    db 11001111b
    db 0


gdt_data32:
    dw 0xFFFF
    dw 0
    db 0
    db 10010010b
    db 11001111b
    db 0


gdt_code64:
    dw 0
    dw 0
    db 0
    db 10011000b
    db 00100000b
    db 0


gdt_data64:
    dw 0
    dw 0
    db 0
    db 10010010b
    db 00000000b
    db 0


gdt_end:


gdt_descriptor:
    dw gdt_end - gdt_start - 1
    dd gdt_start


CODE32 equ gdt_code32 - gdt_start
DATA32 equ gdt_data32 - gdt_start

CODE64 equ gdt_code64 - gdt_start
DATA64 equ gdt_data64 - gdt_start
