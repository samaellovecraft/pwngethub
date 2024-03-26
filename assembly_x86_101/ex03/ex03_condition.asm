global _start

section .text
_start:
    mov ecx, 99     ; set `ecx` to 99
    mov ebx, 42     ; exit status is 42
    mov eax, 1      ; `sys_exit` syscall
    cmp ecx, 100    ; compare `ecx` to 100
    jmp skip        ; jump if less than
    mov ebx, 13     ; exit status is 13
    ; ^ this instruction will be skipped if the jump is made
skip:
    int 0x80
