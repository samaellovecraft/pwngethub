global _start

section .text
_start:
    mov ebx, 42     ; exit status is 42
    mov eax, 1      ; `sys_exit` syscall
    jmp skip        ; jump to `skip` label
    mov ebx, 13     ; exit status is 13
    ; ^ this instruction will be skipped if the jump is made
skip:
    int 0x80
