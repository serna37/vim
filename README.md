# setup
```setup_command.sh
curl https://raw.githubusercontent.com/serna37/vim/master/.vimrc > ~/.vimrc
```

and execute command
```initiation.vim
:PlugInstall
↓after reboot
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

# action cheat sheet

# WINDOW
- Ctrl + q/p : prev / next buffer
- Space x : close buffer
- Ctrl + hjkl : move window forcus
- ↑↓←→ : resize window
- Space t : terminal (bottom)
- Space tp : terminal (popup window)

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
- \* : search word (original vim but dont move cursor)
- \# : search word (original vim but dont move cursor)
- Space q : quit search highlight
- Space s : grep interactive from current buffer (coc-lists)
- Space g : grep interactive Recursive (ripgrep by fzf.vim)

## marking
- mm : marking toggle
- Space m : show mark list (coc fzf-preview)

# EDIT
- (visual mode) Ctrl jk : move line
- (insert mode) Ctrl hljk : move cursor

# IDE
- Space d : go to definition
- Space r : find references
- Space v : other IDE functions menu
- Space ? : hover document
- Space , : prev diagnostic
- Space . : next diagnostic
- Space sh : run current line as shell
