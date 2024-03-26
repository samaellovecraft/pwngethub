global _start
section .data
    addr db "yellow"
section .text
_start:
    mov [addr], byte 'H'    ; 'y' -> 'H'
    mov [addr+5], byte '!'  ; 'w' -> '!'
    mov eax, 4      ; `sys_write` sys call
    mov ebx, 1      ; `stdout` file descriptor
    mov ecx, addr   ; bytes to write
    mov edx, 6      ; number of bytes to write
    int 0x80        ; perform sys call
    mov eax, 1      ; `sys_exit` sys call
    mov ebx, 0      ; exit status is 0
    int 0x80
