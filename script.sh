#!/bin/bash
# Author: Extradev
# Date: 06/09/2021
# Git: https://github.com/ExtraDev/file_location

folder_from=$1
folder_to=$2

if [ -z "$folder_from" ] ||[ -z "$folder_to" ]; then
    echo "Le script doit être utilisé de la manière suivante:"
    echo "bash script.sh [dossier_cible] [dossier_destination]"
    echo "exemple: bash script.sh ~/Download/ ~/Pictures/"
    exit 1
fi

choice=0
while [ $choice -eq 0 ]; do
    echo "Quel est le type de fichier à rechercher?"
    echo "1: Images: jpg, jpeg, jfif ,pjpeg, png, pjp, svg, bmp, gif"
    echo "2: Vidéos: mp4, mov, "
    echo "3: Audios: mp3, "
    echo "4: Documents: pdf, doc, docx, xls, xlsx, ppt, txt, psd"
    echo "5: Tous les formats présenté ci-dessus (1,2,3,4)"
    echo "6: Autre"
    echo "---------------------------------------------------------------"
    echo ""

    printf "Entrez le numéro concernant le type de fichier recherché: \n"
    read number_choice
    echo ""

    echo "Vous avez choisi le choix N°$number_choice, est-ce correct? [y/n]"
    read correct
    echo ""

    if [ "$correct" = "y" ]; then
        choice=1
    fi
done
time=$(date +"%T")
echo "Début de la recherche à: $time"
case $number_choice in
    1)
        echo "Images"
        find $folder_from -name "*.png" -or -name "*.PNG" -or -name "*.jpg" -or -name "*.JPG" -or -name "*.jpeg" -or -name "*.JPEG" -or -name "*.jfif" -or -name "*.JFIF" -or -name "*.svg" -or -name "*.SVG" -or -name "*.gif" -or -name "*.GIF" -or -name "*.bmp" -or -name "*.BMP" > files.txt
    ;;
    2)
        echo "Vidéos"
        find $folder_from -name "*.mov" -or -name "*.dv" -or -name "*.m4v" -or -name "*.avi" -or -name "*.mpeg" -or -name "*.wav" -or -name "*.mp4" -or -name "*.qt" -or -name "*.flv" -or -name "*.wmv" -or -name "*.asf" -or -name "*.mpg" -or -name "*.vob" -or -name "*.mkv" -or -name "*.asf" > files.txt
    ;;
    3)
        echo "Audios"
        find $folder_from -name "*.aac" -or -name "*.aif" -or -name "*.aup" -or -name "*.cda" -or -name "*.flac" -or -name "*.m3u" -or -name "*.m4a" -or -name "*.mid" -or -name "*.midi" -or -name "*.mp3" -or -name "*.mpa" -or -name "*.oga" -or -name "*.ogg" -or -name "*.ra"  -or -name "*.ram"  -or -name "*.wav"  -or -name "*.wma"> files.txt
    ;;
    4)
        echo "Documents"
        find $folder_from -name "*.pdf" -or -name "*.doc" -or -name "*.docx" -or -name "*.xls" -or -name "*.xlsx" -or -name "*.ppt" -or -name "*.psd" -or -name "*.md" -or -name "*.osd" -or -name "*.odt" -or -name "*.odp" > files.txt
    ;;
    5)
        echo "Tous les types proposés"
    ;;
    6)
        echo "Autre, indiquez le format recherché, Par exemple: .pdf"
        read format
        echo ""
        find $folder_from -name "*$format" > files.txt
    ;;
esac

echo ""
time=$(date +"%T")
echo "Fin de la recherche à: $time"
echo ""

nb_files=$(cat files.txt | wc -l)
echo "$nb_files fichiers ont été retrouvé!"
echo ""

echo "Voulez-vous:"
echo "1) les copier dans le dossier $folder_to (recommandé)"
echo "2) les déplacé dans le dossier $folder_to"
echo "3) Ne rien faire"
echo ""
read number_traitement
echo ""

echo ""
time=$(date +"%T")
echo "Début du traitement: $time"
echo ""

# Compute each file detected
cpt=1
while read -r line; do
    case $number_traitement in
    1)
        cp --preserve "$line" $folder_to
    ;;
    2)
        mv "$line" $folder_to
    ;;
    3)
        exit 1
    ;;
    esac

    echo -ne "$cpt/$nb_files: $line"\\r
    let "cpt+=1"
done < files.txt

echo ""
time=$(date +"%T")
echo "Fin du traitement: $time"
echo ""

echo "Fin du programme"