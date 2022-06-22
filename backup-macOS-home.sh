#!/usr/bin/env zsh
# backup-macOS-home.sh

ISODATE=$(date -u +"%Y%m%dT%H%M%SZ") 
DESTINATION="$HOME/OneDrive - Bayer/Backup/$ISODATE"

# make sure not include secret files

FILES=(
    'Library/Application Support/Google/Chrome/Default/Bookmarks.bak'
    '.zshrc'
)

FOLDERS=(
    'Pictures'
    'Desktop'
    'Documents'
)

[[ -n $DESTINATION ]] && mkdir -pv $DESTINATION
if [[ ! -d $DESTINATION ]]
then
    echo "Error: Backup destination directory $DESTINATION does not exist."
    exit -1
fi

LOGFILE=${DESTINATION}/${0}-${ISODATE}.log
echo "Logging to $LOGFILE..."
exec &> ${LOGFILE}

cd $HOME

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

echo "Done. Backup saved to $DESTINATION"