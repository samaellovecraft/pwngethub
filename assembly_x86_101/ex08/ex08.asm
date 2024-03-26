global _start

_start:
    call func
    mov eax, 1
    mov ebx, 0
    int 0x80

func:
    mov ebp, esp    ; preserve the top of the stack (`esp`)
    sub esp, 2      ; allocate 2 bytes on the stack
    mov [esp], byte 'H'
    mov [esp+1], byte 'i'
    mov eax, 4      ; `sys_write` sys call
    mov ebx, 1      ; `stdout` file descriptor
    mov ecx, esp    ; bytes to write
    mov edx, 2      ; num of bytes to write
    int 0x80        ; perform sys call
    mov esp, ebp    ; restore the state of the stack before cthe `call`
    ret
