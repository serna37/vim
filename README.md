# setup
curl https://raw.githubusercontent.com/serna37/vim/master/.vimrc > ~/.vimrc

```initiation.vim
:PlugInstall
reboot
:PlugInstallCoc
```

# monolithic version
or (exclude plugin mode)
curl https://raw.githubusercontent.com/serna37/vim/master/monolithic.vim > ~/.vimrc

```monolithic initiation.vim
<Space>n Azathoth<CR>
```

# snippet
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
