# vim:set foldmethod=marker:

echo "=========================================================="
echo ">>> (0/4). START"
echo ">>> (1/4). MAKE ~/.uranometria/* (if exist skip)"
mkdir -p ~/.uranometria/forge ~/.uranometria/stella ~/.uranometria/zodiac
echo ">>> (2/4). MAKE ~/.uranometria/necronomicon.md (add)"
cat - << "EOF" >> ~/.uranometria/necronomicon.md
# vim:set foldmethod=marker:
# note
{{{
- note1
    > description
}}}

# tasks
{{{
- [ status] sample title
    > description
}}}

# issue
{{{
- issue1
    > description
}}}

# static snippets
{{{
- git
    git checkout . && git clean -df && git status
    git status --short
    git status --short | awk '{print $2}' | xargs
    git log -n 3
    git log --no--merges origin/develop..target_branch
    git show commitid
- kind 1
    some command and so on
    some command and so on
}}}

# archive
{{{
- 2022-11-03
    - [ status] sample title
        > description
    - [ status] sample title
        > description
}}}

EOF
echo ">>> (3/4). MAKE ~/.uranometria/forge/backup.sh (over write)"
cat - << "EOF" > ~/.uranometria/forge/backup.sh
read -sp "Key: " pass
if [ "silver" != "${pass}" ]; then
  exit
fi
cd ~/.uranometria/zodiac
LIMIT=12
PREFIX=ふしぎなおくりもの
FOLDER_NAME=${PREFIX}`date '+%Y-%m-%d'`
# bk
if [ ! -e ./${FOLDER_NAME} ]; then
  mkdir ${FOLDER_NAME}
fi
cp -f ../necronomicon.md ${FOLDER_NAME}
cp -rf ../stella ${FOLDER_NAME}
cp -rf ../forge ${FOLDER_NAME}
# delete over limit
CNT=`ls -l | grep ^d | wc -l`
if [ ${CNT} -gt ${LIMIT} ]; then
  ls -d */ | sort | head -n $((CNT-LIMIT)) | xargs rm -rf
fi
# chk
ls -ail
EOF
echo ">>> (4/4). END CHECK"
echo "=========================================================="
ls -ail ~/.uranometria

