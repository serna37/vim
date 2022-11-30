# Window
- `↑↓←→` : resize window
- `Ctrl + hjkl` : move window forcus
- `Ctrl + udfb` : comfortable scroll
- `Space t` : terminal popup

# Search
- `Space q` : clear search highlight
- `*` : search word (original vim but dont move cursor)
- `#` : search word (original vim but dont move cursor)
- `Space f` : file search
- `Space g` : grep

# Mark
- `Space m` : mark list
- `mm` : marking
- `mj` : next mark
- `mk` : prev mark
- `mw` : mark word (highlight)

# GodSpeed
- `Tab / Shift+Tab` : 
  1. expand anker each 5 rows, jump to anker
  2. expand f-scope highlight
- `Space w` : clear anker, f-scope highlight

# Favorit
- `Space Space n` : Necronomicon (see vimrc)
- `Space Space w` : run cat
- `Space Space s` : stop cat
- `Space Space c` : change colorscheme

# Language
- `Space gd` : go to definition
- `Space gr` : find references
- `Space hd` : hover definition (scroll: Ctrl + jk)
- `Space hh` : hover document
- `Space rr` : rename
- `Space ,` : prev diagnostic
- `Space .` : next diagnostic
- `Space run` : run
- `Space sh` : run current line as shell

" TODO lspで変わる
imap <expr> <Tab> '<C-n>'
inoremap <expr> <S-Tab> pumvisible() ? '<C-p>' : '<S-Tab>'
inoremap <expr> <CR> pumvisible() ? '<C-y>' : '<CR>'
