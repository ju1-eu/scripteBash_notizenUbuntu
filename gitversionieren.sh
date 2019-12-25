#!/bin/bash -e
# letztes Update: 24-Dez-19
# Git versionieren

# Variable
#------------------------------------------------------
# anpassen
#  THEMA="dummy-notizenUbuntu-v03"

#  backup_USB="/media/jan/usb/backup/notizenUbuntu"    
  #backup_RPI4="smb://rpi4.local/nas/backup/notizenUbuntu" 
#  backup_HD="/media/jan/virtuell/backup/notizenUbuntu"

#  archiv_USB="/media/jan/usb/archiv/notizenUbuntu"    
  #archiv_RPI4="smb://rpi4.local/nas/archiv/notizenUbuntu" 
#  archiv_HD="/media/jan/virtuell/archiv/notizenUbuntu"

  repos_USB="/media/jan/usb/repos/notizenUbuntu"    
  #repos_RPI4="smb://rpi4.local/nas/repos/notizenUbuntu" 
  repos_HD="/media/jan/virtuell/repos/notizenUbuntu"
#------------------------------------------------------

info="Git versionieren"
file="git.log"
timestamp=$(date +"%d-%h-%Y")
copyright="ju - $timestamp - $file"

# ----------------------------
echo "+++ $info"

# Voraussetzung:
#
# lokales Repository: HEAD -> master
#  git init # rm -rf .git
#  git add .
#  git commit -m"Projekt init"

   # Github Repository: origin/master
      # anpassen    
#  REPOSITORY="dummy-notizenUbuntu-v03"
#  ADRESSE="git@github.com:ju1-eu"
#  git remote add origin $ADRESSE/$REPOSITORY.git
#  git push --set-upstream origin master

  # backup Repository: backupUSB/master
      # anpassen
#  repos_USB="/media/jan/usb/repos/notizenUbuntu"    
#  REPOSITORY="dummy-notizenUbuntu-v03"
#  LESEZEICHEN="backupUSB"
#  git clone --no-hardlinks --bare . $repos_USB/$REPOSITORY.git 
#  git remote add $LESEZEICHEN $repos_USB/$REPOSITORY.git 
#  git push --all $LESEZEICHEN

  # backup Repository: backupRPI4/master
      # anpassen
#  repos_RPI4="smb://rpi4.local/nas/repos/notizenUbuntu" 
#  REPOSITORY="dummy-notizenUbuntu-v03"
#  LESEZEICHEN="backupRPI4"
#  git clone --no-hardlinks --bare . $repos_RPI4/$REPOSITORY.git 
#  git remote add $LESEZEICHEN $repos_RPI4/$REPOSITORY.git 
#  git push --all $LESEZEICHEN

  # Backup Repository: backupHD/master
#  repos_HD="/media/jan/virtuell/repos/notizenUbuntu"
#  REPOSITORY="dummy-notizenUbuntu-v03"
#  LESEZEICHEN="backupHD"
#  git clone --no-hardlinks --bare . $repos_HD/$REPOSITORY.git 
#  git remote add $LESEZEICHEN $repos_HD/$REPOSITORY.git 
#  git push --all $LESEZEICHEN

# Git-Version
# lokales Repository: HEAD -> master
#
# usereingabe
read -p "lokales Repository vorhanden? [j/n] " antwort
if [ -z "$antwort" ]; then
  # String ist leer
  echo "Keine Eingabe"
fi
if [ "$antwort" = "j" ]; then
  # lokales Repository: HEAD -> master
  git add .
  git commit -a # editor
  echo "# ------------------------"
else
  # beenden
  echo "Ende: $antwort"
fi

# Github Repository: origin/master
#
# usereingabe
read -p "Github Repository vorhanden? [j/n] " antwort
if [ -z "$antwort" ]; then
  # String ist leer
  echo "Keine Eingabe"
fi
if [ "$antwort" = "j" ]; then
  # Github Repository: origin/master
  git push
  echo "# ------------------------"
else
  # beenden
  echo "Ende: $antwort"
fi

# Backup Repository: backupHD/master
#
# usereingabe
read -p "Backup Repository $repos_HD vorhanden? [j/n] " antwort
if [ -z "$antwort" ]; then
  # Fehler: String ist leer
  echo "Keine Eingabe"
fi
if [ "$antwort" = "j" ]; then
  # Speicher - Laufwerk vorhanden?
  if [ ! -d $repos_HD ]; then
    echo "$repos_HD mounten."
  else
    # Backup Repository
    LESEZEICHEN="backupHD"
    git push --all $LESEZEICHEN 
    echo "# ------------------------"
  fi
else
  # beenden
  echo "Ende: $antwort"
fi

# Backup Repository: backupUSB/master
#
# usereingabe
read -p "Backup Repository $repos_USB vorhanden? [j/n] " antwort
if [ -z "$antwort" ]; then
  # Fehler: String ist leer
  echo "Keine Eingabe"
fi
if [ "$antwort" = "j" ]; then
  # Speicher - Laufwerk vorhanden?
  if [ ! -d $repos_USB ]; then
    echo "$repos_USB mounten."
  else
    # Backup Repository
    LESEZEICHEN="backupUSB"
    git push --all $LESEZEICHEN 
    echo "# ------------------------"
  fi
else
  # beenden
  echo "Ende: $antwort"
fi

echo "# ------------------------"
git status
git lg

echo $copyright > $file
git lg >> $file
echo "# ------------------------"

echo "fertig"
