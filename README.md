# Bend That Learning Curve

The idea of this repo is for me to make a valuable commit to my personal growth and future (ideally) every day.

test 
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


see [ex06](exploit)

> [!NOTE]
> the object file for this excercise should be linked with `gcc` because it's easier to include C standard lib with it:
> ```bash
> gcc -m32 ex10.o -o ex10
> ```
> also you will probably have to install the 32-bit development packages:
> ```bash
> sudo apt install gcc-multilib
> ```

> [!IMPORTANT]
> since the caller pushes the args onto the stack, it's also their responsibility to remove them from the stack when the call is done
