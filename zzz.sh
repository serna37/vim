echo "=========================================================="
echo ">>> (0/6). START"
echo ">>> (1/6). MAKE ~/* (if exist skip)"
mkdir -p ~/forge ~/work ~/backup
echo ">>> (2/6). TOUCH ~/necronomicon.md"
touch ~/necronomicon.md
echo ">>> (3/6). MAKE ~/forge/backup.sh (over write)"
cat - << "EOF" > ~/forge/backup.sh
read -sp "Key: " pass
if [ "silver" != "${pass}" ]; then
  exit
fi
cd ~/backup
LIMIT=12
PREFIX=ふしぎなおくりもの
FOLDER_NAME=${PREFIX}`date '+%Y-%m-%d'`
# bk
if [ ! -e ./${FOLDER_NAME} ]; then
  mkdir ${FOLDER_NAME}
fi
cp -f ../necronomicon.md ${FOLDER_NAME}
cp -rf ../work ${FOLDER_NAME}
cp -rf ../forge ${FOLDER_NAME}
# delete over limit
CNT=`ls -l | grep ^d | wc -l`
if [ ${CNT} -gt ${LIMIT} ]; then
  ls -d */ | sort | head -n $((CNT-LIMIT)) | xargs rm -rf
fi
EOF
echo ">>> (4/6). MAKE ~/forge/cheat_sheet.md (over write)"
cat - << "EOF" > ~/forge/cheat_sheet.md
# Plugin
- command `PlugInstall` : install plugin
- command `PlugUnInstall` : uninstall plugin, uninstall language-server

# Window
- `↑↓←→` : resize window
- `Ctrl + hjkl` : move window forcus
- `Ctrl + udfb` : comfortable scroll
- `Space t` : terminal popup
- `(visual choose) Ctrl jk` : move line text

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
  1. expand anker each 6 rows, jump to anker
  2. expand f-scope highlight
- `Space w` : clear anker, f-scope highlight, mark highlight

# Favorit
- `Space Space n` : Necronomicon (see vimrc)
- `Space Space w` : run cat
- `Space Space s` : stop cat
- `Space Space c` : change colorscheme

# Language
- `Space lgd` : go to definition
- `Space lgr` : find references
- `Space ldd` : hover document
- `Space lrr` : rename
- `Space lff` : format
- `Space ,` : prev diagnostic
- `Space .` : next diagnostic
- `Space run` : run
- `Space sh` : run current line as shell

EOF
# TODO make plugin shell
echo ">>> (5/6). MAKE ~/forge/plugins.sh (over write)"
cat - << "EOF" > ~/forge/plugins.sh
EOF
echo ">>> (6/6). END"
echo "=========================================================="

