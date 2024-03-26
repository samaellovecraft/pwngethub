global main ; c defines `_start` by itself and expects the code to provide a label `main`
extern printf

section .data
    msg db "Testing %i...", 0x0a, 0x00 ; <- new line and null terminator

section .text
main:
    push ebp
    mov ebp, esp
    push 123    ; the args are pushed
    push msg    ; in reverse order
    call printf ; printf(msg, 123)
    mov eax, 0
    mov esp, ebp
    pop ebp
    ret
