; Enable Long Mode
mov ecx, 0xC0000080
rdmsr

or eax, 1 << 8

wrmsr


; Enable Paging
mov eax, cr0
or eax, 1 << 31
mov cr0, eax


jmp CODE64:long_mode
