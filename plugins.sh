mkdir -p ~/.vim/pack/plugins/start && cd ~/.vim/pack/plugins/start
repos=(
'prabirshrestha/vim-lsp'
'mattn/vim-lsp-settings'
)
for v in ${repos[@]}; do
  git clone --depth 1 "https://github.com/${v}"
done
