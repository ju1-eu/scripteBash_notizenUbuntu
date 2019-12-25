#!/bin/bash -e
# letztes Update: 24-Dez-19
# pdfname - Suchen und Ersetzen anpassen

# Shell: >_
# Github Repository downloaden
# git clone git@github.com:ju1-eu/dummy-notizenUbuntu-v03.git .
  # oder
# Backup Repository
# git clone /media/jan/virtuell/repos/notizenUbuntu/dummy-notizenUbuntu-v03.git .

#------------------------------------------------------------
clear

# anpassen
# Backup Repository
SSD="/media/jan/virtuell/repos/notizenUbuntu"

work="/home/jan/tex"
cd $work

# datum
TIMESTAMP=$(date +"%d-%h-%Y")
echo "ju - $TIMESTAMP - Script: Suchen und Ersetzen"


# usereingabe
echo "#---------------------"
read -p "Backup Repository 'dummy-notizenUbuntu-v03' vorhanden? [j/n] " a
if [ -z "$a" ]; then
  # String ist leer
  echo "Keine Eingabe"
fi
if [ "$a" = "j" ]; then
  echo "#---------------------"
  # pdfname="xxx"
  read -p "Eingabe: PDF-Name >_ " pdfname
  PDFNAME_NOTIZ="$pdfname-Notiz"
  if [ ! -d ./$PDFNAME_NOTIZ ]; then mkdir -p ./$PDFNAME_NOTIZ; fi

  # Backup Repository
  if [ `ls -a  $PDFNAME_NOTIZ | wc -l` -gt 2 ]; then
    echo "'$PDFNAME_NOTIZ' nicht leer! 'git clone' wird nicht ausgeführt."
    exit
  else
    cd $PDFNAME_NOTIZ
    git clone $SSD/dummy-notizenUbuntu-v03.git .
  fi

  echo "#---------------------"
  read -p "Backup Repository '$PDFNAME_NOTIZ-backup' erstellen? [j/n] " b
  if [ -z "$b" ]; then
    # String ist leer
    echo "Keine Eingabe"
  fi
  if [ "$b" = "j" ]; then
    echo "#---------------------"
    cd ..
    # suchen und ersetzen
    # anpassen
    folder="$PDFNAME_NOTIZ"
    suchen="dummy-notizenUbuntu-v03"
    suchen_sed_reg="dummy-notizenUbuntu-v03" # sed  https:\/\/bw1.eu
    ersetzen="$PDFNAME_NOTIZ"
    echo "Suche: $suchen -> Ersetze: $ersetzen"

    # Suche vorher
    printf "Suchtreffer vorher: "
    grep -r $suchen $folder/ |wc -l

    # usereingabe
    #read -p "Ordner der Duchsucht werden soll: " folder
    #read -p "Suchen: " suchen
    #read -p "Ersetzen: " ersetzen

    echo "Verarbeitung beginnt..."
    find $folder/ -type f -print0 | xargs -0 sed -i -e "s/$suchen_sed_reg/$ersetzen/g"

    # Suche nachher
    printf "Suchtreffer nachher: "
    grep -r $suchen $folder/|wc -l
    echo "#---------------------"

    # git init
    cd $PDFNAME_NOTIZ
		rm -rf .git
		git init
		git add .
		git commit -am "Projekt init"

    echo "#---------------------"
    repository="$PDFNAME_NOTIZ"
    if [ ! -d $SSD/$repository.git ]; then
        git clone --no-hardlinks --bare . $SSD/$repository.git
        git remote add backup-ssd $SSD/$repository.git
        git push --all backup-ssd
    fi

  else
    # beenden
    echo "Ende: $b"
  fi

  cd ..

else
  # beenden
  echo "Ende: $a"
fi

echo "#---------------------"
echo "Sind alte Notizen vorhanden? Wenn ja,..."
echo "Verzeichnisse '$pdfname/code, , md, Tabellen' kopieren nach '$PDFNAME_NOTIZ/' ?"
read -p "Eingabe [j/n] >_ " c
if [ -z "$c" ]; then
  # String ist leer
  echo "Keine Eingabe"
fi
if [ "$c" = "j" ]; then
  # Kopie
  # Option: -u	überspringt Dateien, die im Ziel neuer sind als in der Quelle
  code="code"
  img="images"
  md="md"
  tabellen="Tabellen"
  verz_alt="$pdfname"
  verz_neu="$PDFNAME_NOTIZ"

  rsync -a $verz_alt/$code/ $verz_neu/$code/
  rsync -a $verz_alt/$img/ $verz_neu/$img/
  rsync -a $verz_alt/$md/ $verz_neu/$md/
  rsync -a $verz_alt/$tabellen/ $verz_neu/$tabellen/
else
  # beenden
  echo "Ende: $c"
fi

echo "#---------------------"
echo "+++ Erste Schritte +++"
echo "
$ cd $PDFNAME_NOTIZ

# files anpassen
scripte/sed.sh
  - codelanguage:    HTML5, Python, Bash, C, C++, TeX
  - CMS Server Pfad: https://www.ju1.eu/#
  - Bildformat:      pdf, svg, png, jpg

projekt.sh
  - Backupverzeichnis

content/metadata.tex
  - Datum, Titel, Autor

$ ./projekt.sh
  # Projekt erstellen"
echo "#---------------------"

echo "Script beendet."
