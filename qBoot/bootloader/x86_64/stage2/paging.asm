; PML4
mov dword [0x90000], 0x91003
mov dword [0x90004], 0

; PDPT
mov dword [0x91000], 0x92003
mov dword [0x91004], 0

; Page Directory
mov dword [0x92000], 0x000083
mov dword [0x92004], 0

; Load PML4
mov eax, 0x90000
mov cr3, eax

; Enable PAE
mov eax, cr4
or eax, 1 << 5
mov cr4, eax
