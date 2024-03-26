global _start

_start:
    call func   ; pushes the next instruction onto the stack
    mov eax, 1
    int 0x80

func:
    mov ebx, 42
    pop eax     ; pops that location of the code off of the stack and stores it in `eax`
    jmp eax     ; jumps to instruction stored in `eax`
