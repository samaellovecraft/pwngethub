; the `global` keyword is used to make an *identifier* accessible to the linker
global _start
; the identifier followed by a `:` will create a *label*
; labels are used to name locations in the code
_start: ; program's entry point
    mov eax, 1 ; moves int 1 into `eax` register
    mov ebx, 42 ; moves int 42 into `ebx` register
    int 0x80 ; performs an interrupt:
    ; - the processor will transfer control to an *interrupt handler* (`0x80`) - an interrupt handler for syscalls
    ; - the syscall that it makes will be determined by `eax` register (the value 1 is a `sys_exit` system call)
    ; - the value stored in `ebx` will be the exit status for the program
