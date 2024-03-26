global _start

section .data
    ; string of bytes:
    msg db "Hello, world!", 0x0a ; <- \n
    ; calculate the length of the string:
    len equ $ - msg ; subtract the location of the start of the string (`msg`) from the location after the string (`$`)

section .text
_start:
    mov eax, 4      ; `sys_write` system call
    mov ebx, 1      ; `stdout` file descriptor
    mov ecx, msg    ; bytes to write
    mov edx, len    ; number of bites to write
    int 0x80        ; perform system call
    mov eax, 1      ; `sys_exit` system call
    mov ebx, 0      ; exit status is 0
    int 0x80
