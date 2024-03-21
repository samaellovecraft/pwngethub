# Bend That Learning Curve

The idea of this repo is for me to make a valuable commit to my personal growth and future (ideally) every day.

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
    - **Explanation**: [code](https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/server_configurations/asm_lsp.lua) -> `root_dir = util.find_git_ancestor` (it's noticeable that other lsp servers have different implementations) 
    - **Fix**: fixed by:
    ```lua
    lspconfig.asm_lsp.setup({ root_dir = require('lspconfig.util').root_pattern('.asm-lsp.toml', '.git', '*.asm', '*.s', '*.S') })
    ```

    - **Fix**: fixed by (link):
    ```lua
    lspconfig.asm_lsp.setup({ root_dir = require('lspconfig.util').root_pattern('.asm-lsp.toml', '.git', '*.asm', '*.s', '*.S') })`
    ```


