#!/usr/bin/env zsh
# backup-macOS-home.sh

FILES=(
    'Library/Application Support/Google/Chrome/Default/Bookmarks.bak'
    '.zshrc'
    '.zsh_history'
)

FOLDERS=(
    'Pictures'
    'Desktop'
    'Documents'
)

ISODATE=$(date -u +"%Y%m%dT%H%M%SZ") 
DESTINATION=$HOME/Backup/$ISODATE

[[ -n $DESTINATION ]] && mkdir -pv $DESTINATION
if [[ ! -d $DESTINATION ]]
then
    echo "Error: Backup destination directory $DESTINATION does not exist."
    exit -1
fi

exec &> ${DESTINATION}/${0}.log

cd $HOME
echo "Zipping folders..."
for i in $FOLDERS; do
    if [[ -d $i ]]
    then
        # tar cvzf ${DESTINATION}.tar.gz $i
        zip -r ${DESTINATION}/${i}.zip $i
    else
        echo "Error: Directory $i is not readable."
        exit -1
    fi
done

echo "Copying files..."
for i in $FILES; do
    if [[ -r $i ]]
    then
        cp -v $i $DESTINATION
    else
        echo "Error: File $i is not readable."
        exit -1
    fi
done

echo "Done. Backup saved to $DESTINATION"