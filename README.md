# setup
```setup_command.sh
curl https://raw.githubusercontent.com/serna37/vim/master/.vimrc > ~/.vimrc
```

and execute command
```initiation.vim
:PlugInstall
↓after vim reboot
:PlugInstallCoc
```

<details>
<summary>(old) monolithic version</summary>
# monolithic version
or (exclude plugin mode)
curl https://raw.githubusercontent.com/serna37/vim/master/monolithic.vim > ~/.vimrc

```monolithic initiation.vim
<Space>n Azathoth<CR>
```

# snippet(for v-snip)
for vsnip, this is "create snippet" snippet

```vsnip.json
{
    "sni": {
        "prefix": ["sni"],
        "body": [
            ",\"${1}\": {"
            ,"  \"prefix\": [\"${2}\"],"
            ,"  \"body\": [\"${3}\"]"
            ,"}"
        ]
    }

}
```

</details>

# My action cheat sheet
# Basic
- normal vim
- fzf popup window

# WINDOW
- Ctrl + q/p : prev / next buffer
- Space x : close buffer
- Ctrl + hjkl : move window forcus
- ↑↓←→ : resize window
- Space t : terminal (bottom)
- Space z : zen mode

# MOTION
- tab / Shift-tab : 5row jump
- Ctrl + udfb : comfortable scroll
- Space w : f-scope toggle

# SEARCH
## file search
- Space e : explorer
- Space f : fuzzy finder files / git files
- Space h : fuzzy finder history
- Space b : fuzzy finder buffer

## word serch
- s : jump word with easy-motion
- Space s : incremental search word with easy-motion
- Space Space s : grep interactive from current buffer (coc-lists)
- \* : search word (original vim but dont move cursor)
- \# : search word (original vim but dont move cursor)
- Space q : quit search highlight
- Space g : grep interactive Recursive (ripgrep)

## mark
- mm : marking toggle
- Space m : show mark list (coc fzf-preview)

## jump
- Space l : line (= NUM+G, but preview window)
- Space j : jump history
- Space c : changed line

# EDIT
- (visual mode) Ctrl jk : move line
- (insert mode) Ctrl hljk : move cursor

# IDE
- Space d : go to definition
- Space r : (popup) find references
- Space o : (popup) outline
- Space v : other IDE functions menu
- Space ? : hover document
- Space , : prev diagnostic
- Space . : next diagnostic

# on popup
- Ctrl + n/p : chose down/up
- Ctrl + d/u : preview down/up
- Tab : select
- Ctrl + q : selections -> quickfix
(with quickfix -> fzf-preview.QuickFix)
