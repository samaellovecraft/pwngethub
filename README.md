# Bend That Learning Curve

The idea of this repo is for me to make a valuable commit to my personal growth and future (ideally) every day.

see [test](test/) 
## Mastering NeoVim

- vim motions:
    - [x] vimtutor (legend says my stepsis is still stuck on this step)
    - [ ] [theprimeagen's playlist](https://www.youtube.com/playlist?list=PLm323Lc7iSW_wuxqmKx_xxNtJC_hJbQ7R)
    - [x] everyday practice (this file was created and edited in vim btw)
- config:
    - [x] [typecraft's playlist](https://www.youtube.com/playlist?list=PLsz00TDipIffreIaUNk64KxTIkQaGguqn) 
    - [x] [Neovim Config - Part 1 - Lazy Vim](https://www.youtube.com/watch?v=ZWWxwwUsPNw)
    - [x] [Neovim Config - Part 2 - Awesome Remaps and Restructuring Lazy Vim](https://www.youtube.com/watch?v=c0Xmd4PGino)
    - [ ] [Neovim Config - Part 3 - LSP](https://www.youtube.com/watch?v=MuUrCcvE-Yw)

### TODO

- [x] figure the shit out of `asm-lsp`:
    - **Issue**: filetype detected but `0 client(s) attached to this buffer` & `root directory not found` ([link to identical issue](https://www.reddit.com/r/neovim/comments/16x65f9/has_anyone_had_any_issues_with_asmlsp/))
    - **Clue**: can be fixed with `git init` (awful)
    - **Explanation** ([source](https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/asm_lsp.lua)): `root_dir = util.find_git_ancestor` (it's noticeable that other lsp servers have different implementations) 
    - **Fix** (link):
    ```lua
    lspconfig.asm_lsp.setup({ root_dir = require('lspconfig.util').root_pattern('.asm-lsp.toml', '.git', '*.asm', '*.s', '*.S') })
    ```

> [!NOTE] TEST
> teste

# Intro to x86 Assembly

[yt playlist](https://www.youtube.com/watch?list=PLmxT2pVYo5LB5EzTPZGfFN0c2GDiSXgQe)

the `global` keyword is used to make an *identifier* accessible to the linker:
```asm
global _start
```
the identifier followed by a `:` will create a *label*; labels are used to name locations in the code
```asm
_start: ; program's entry point
```

## mov

```asm
mov eax, 1 ; moves int 1 into `eax` register
mov ebx, 42 ; moves int 42 into `ebx` register
```

## int

```asm
int 0x80 ; performs an interrupt
```
- the processor will transfer control to an *interrupt handler* (`0x80`) - an interrupt handler for system calls
- the system call that it makes will be determined by `eax` register (e.g., the value 1 is a `sys_exit` system call)
- the value stored in `ebx` will be the exit status for the program

## eax

```asm
mov eax, 4      ; `sys_write` sys call
mov eax, 1      ; `sys_exit` system call
```

## ebx

```asm
mov ebx, 1      ; `stdout` file descriptor
mov ebx, 0      ; exit status is 0
```

## Math

```asm
mov ebx, 123 ; ebx = 123
mov eax, ebx ; eax = ebx
add ebx, ecx ; ebx += ecx
sub ebx, edx ; ebx -= edx
mul ebx      ; eax *= ebx
div edx      ; eax /= edx
```

## Utils

use `nasm` to assemble the program into machine code:
```bash
nasm -f elf32 ex01.asm -o ex01.o
```
use `ld` (linker) to build an executable from the object file:
```bash
ld -m elf_i386 ex01.o -o ex01
```
or use a custom [Makefile](Makefile):
```bash
make FILE=ex01/ex01.asm
```

## Instruction Pointer (EIP)

- shows location of execution
- not like a register
- can be changed by jump ops

## Common Jump Ops

```asm
je A, B     ; jump if equal
jne A, B    ; jump if not equal
jg A, B     ; jump if greater
jge A, B    ; jump if greater or equal
jl A, B     ; jump if less
jle A, B    ; jump of less or equal
```

> [!IMPORTANT]
> jump ops introduce conditional statements (see [ex03](ex03/ex03_condition.asm)) and loops (see [ex04](ex04/ex04.asm)).

## Common Data Types

- `db` stands for "define byte" (1 byte)
- `dw` stands for "define word" (2 bytes)
- `dd` stands for "define double word" (4 bytes)

```asm
section .data
    name1 db "string"
    name2 db 0xff
    name3 db 100
    name4 dw 1000
    name5 dd 100000
```

## Stack

- LIFO data structure
- is an array
- has a pointer (register) to the top of it (ESP)
- we have random access to its memory, meaning that we can read and write from arbitrary locations within it (see [ex05](ex05/ex05.asm) and [ex06](ex06/ex06.asm))

```asm
push 1234
push 8765
push 246
sub esp, 4              ; these operations are the equivalent of:
mov [esp], dword 357    ; push 357
```

> [!NOTE]
> `sub esp, 4` effectively allocates 4 bytes on the stack.

```asm
push 1234
push 8765
push 246
push 357
mov eax, dword [esp]    ; these operations are the equivalent of:
add esp, 4              ; pop eax
```

## Function-like functionality with `call`

- pushes EIP to stack
- performs a jump (advantage over a simple jump: you don't have to hardcode the location to return to)

```
global _start

_start:
    call func   ; pushes the next instruction onto the stack
    mov eax, 1
    int 0x80

func:
    mov ebx, 42
    pop eax     ; pops that location of the code off of the stack and stores it in `eax`
    jmp eax     ; jumps to instruction stored in `eax`
```

### `ret`

this code is equivalent to the code above:
```asm
global _start

_start:
    call func
    mov eax, 1
    int 0x80

func:
    mov ebx, 42
    ret
```

### Preserving the stack with EBP

```asm
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
    mov esp, ebp    ; restore the state of the stack before the `call`
    ret
```

> [!IMPORTANT]
> if the `func` were to call another fucntion that stores the value of `esp` in `ebp` (`mov ebp, esp`), it would alter the previous value of `ebp`. thus, taking away the ability to restore the state of the stack to its original state before the `func` call.

Here's a common technique to circumvent that:
```asm
func:
    push ebp
    ; some logic here
    pop ebp
```

### Function anatomy

```asm
func:
    push ebp        ; prologue
    mov ebp, esp    ; of the
    sub esp, 2      ; function
    mov [esp], byte 'H'
    mov [esp+1], byte 'i'
    mov eax, 4
    mov ebx, 1
    mov ecx, esp
    mov edx, 2
    int 0x80
    mov esp, ebp    ; epilogue
    pop ebp         ; of the
    ret             ; function
```

### Passing values to and returning them from functions

see [ex09](ex09/ex09.asm)

```asm
global _start

_start:
    push 21
    call times2
    mov ebx, eax
    mov eax, 1
    int 0x80

times2:
    push ebp
    mov ebp, esp
    mov eax, [ebp+8] ; read the 1st arg
    add eax, eax
    mov esp, ebp
    pop ebp
    ret
```

### Using external functions

see [ex10](ex10/ex10.asm)

> [!NOTE]
> the object file for this excercise should be linked with `gcc` because it's easier to include C standard lib with it:
> ```bash
> gcc -m32 ex10.o -o ex10
> ```
> also you will probably have to install the 32-bit development packages:
> ```bash
> sudo apt install gcc-multilib
> ```

```asm
global main ; c defines `_start` by itself and expects the code to probive a label `main`
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
```

> [!IMPORTANT]
> since the caller pushes the args onto the stack, it's also their responsibility to remove them from the stack when the call is done (beware: the `call` instruction wont do this for you and if you make too many calls without popping them you will grow the stack quite a bit which will use up more memory than is needed)

