global _start
_start:
    mov eax, 1
    mov ebx, 42
    sub ebx, 29 ; subtracts 29 from `ebx` register value (42)
    int 0x80 ; return status code (42 - 29) = 13
