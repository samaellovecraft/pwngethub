global add21

add21:
    push ebp
    mov ebp, esp
    mov eax, [ebp+8] ; 
    add eax, 21
    mov esp, ebp
    pop ebp
    ret
