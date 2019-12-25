# Readme
<!--letztes Update: 25-Dez-19-->
## Erste Schritte - Script THEMA-umbenennen.sh ausführen

Erstellt Ordner für Notizen: Thema-Notiz = TCP_IP-Praxis-Notiz

Erstellt Backup Repository

~~~
  # THEMA - Suchen und Ersetzen anpassen
  vi THEMA-umbenennen.sh
  # script ausführen
  ./THEMA-umbenennen.sh
~~~

## dummy-notizenUbuntu-v03 Repository von Github downloaden

<https://github.com/ju1-eu>

**Repository Name** = dummy-notizenUbuntu-v03

**Repository Name Neu** = TCP_IP-Praxis-Notiz

~~~
  # Github Repository downloaden
  REPOSITORY="dummy-notizenUbuntu-v03"
  ADRESSE="git@github.com:ju1-eu"
  git clone $ADRESSE/$REPOSITORY.git TCP_IP-Praxis-Notiz

  # Backup Repository clonen
  repos_HD="/media/jan/virtuell/repos/notizenUbuntu"
  REPOSITORY="dummy-notizenUbuntu-v03"
  git clone $repos_HD/$REPOSITORY.git TCP_IP-Praxis-Notiz

  repos_USB="/media/jan/usb/repos/notizenUbuntu"    
  REPOSITORY="dummy-notizenUbuntu-v03"
  git clone $repos_USB/$REPOSITORY.git TCP_IP-Praxis-Notiz
~~~

## Neues Repository auf Github anlegen

<https://github.com/ju1-eu>

**Repository Name** = TCP_IP-Praxis-Notiz

~~~
  # lokales Repository: HEAD -> master
  git init # rm -rf .git
  git add .
  git commit -m"Projekt init"

  # Github Repository: origin/master
      # anpassen    
  REPOSITORY="TCP_IP-Praxis-Notiz"
  ADRESSE="git@github.com:ju1-eu"
  git remote add origin $ADRESSE/$REPOSITORY.git
  git push --set-upstream origin master

  # backup Repository: backupUSB/master
      # anpassen
  repos_USB="/media/jan/usb/repos/notizenUbuntu"    
  REPOSITORY="TCP_IP-Praxis-Notiz"
  LESEZEICHEN="backupUSB"
  git clone --no-hardlinks --bare . $repos_USB/$REPOSITORY.git
  git remote add $LESEZEICHEN $repos_USB/$REPOSITORY.git
  git push --all $LESEZEICHEN

  # Backup Repository: backupHD/master
  repos_HD="/media/jan/virtuell/repos/notizenUbuntu"
  REPOSITORY="TCP_IP-Praxis-Notiz"
  LESEZEICHEN="backupHD"
  git clone --no-hardlinks --bare . $repos_HD/$REPOSITORY.git
  git remote add $LESEZEICHEN $repos_HD/$REPOSITORY.git
  git push --all $LESEZEICHEN
~~~

Git Befehle

~~~
  # Shell $
  #
  # ".gitconfig", ".gitignore" erstellen und konfigurieren
  #
  # git versionieren
  git add .
  git commit -a # Editorauswahl: sudo update-alternatives --config editor
  git status
  git log --graph --oneline
  git lg > git.log

  # Github Repository
  git pull
  git push

  # Backup Repository
  git remote -v
  git push --all backupHD # sichern
  git push --all backupUSB

  # Branch erstellen
  git checkout -b feature/a1
  git checkout feature/a1
  # projekt bearbeiten
  git checkout master
  git merge feature/a1

  git status
  git log
  git lg
  git log --graph --oneline # beenden q
  git log --graph --pretty=format:";  %cn;  %h;  %ad;  %s" --date=relative > git.log
~~~

## Repository von Github downloaden

<https://github.com/ju1-eu>

**Repository Name** = TCP_IP-Praxis-Notiz

~~~
  # Shell $

  # Github Repository downloaden
  REPOSITORY="TCP_IP-Praxis-Notiz"
  ADRESSE="git@github.com:ju1-eu"
  git clone $ADRESSE/$REPOSITORY.git

  # Backup Repository clonen
  repos_HD="/media/jan/virtuell/repos/notizenUbuntu"
  REPOSITORY="TCP_IP-Praxis-Notiz"
  git clone $repos_HD/$REPOSITORY.git

  repos_USB="/media/jan/usb/repos/notizenUbuntu"    
  REPOSITORY="TCP_IP-Praxis-Notiz"
  git clone $repos_USB/$REPOSITORY.git
~~~
