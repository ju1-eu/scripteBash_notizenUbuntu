# Scripte Bash 
<!--letztes Update: 25-Dez-19-->
## Neues Repository auf Github anlegen

<https://github.com/ju1-eu>

**Repository Name** = scripteBash_notizenUbuntu 

~~~
  # lokales Repository: HEAD -> master
  git init # rm -rf .git
  git add .
  git commit -m"Projekt init"

  # Github Repository: origin/master
      # anpassen    
  REPOSITORY="scripteBash_notizenUbuntu"
  ADRESSE="git@github.com:ju1-eu"
  git remote add origin $ADRESSE/$REPOSITORY.git
  git push --set-upstream origin master

  # backup Repository: backupUSB/master
      # anpassen
  repos_USB="/media/jan/usb/repos/notizenUbuntu"    
  REPOSITORY="scripteBash_notizenUbuntu"
  LESEZEICHEN="backupUSB"
  git clone --no-hardlinks --bare . $repos_USB/$REPOSITORY.git 
  git remote add $LESEZEICHEN $repos_USB/$REPOSITORY.git 
  git push --all $LESEZEICHEN

  # Backup Repository: backupHD/master
  repos_HD="/media/jan/virtuell/repos/notizenUbuntu"
  REPOSITORY="scripteBash_notizenUbuntu"
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

**Repository Name** = scripteBash_notizenUbuntu

~~~
  # Shell $

  # Github Repository downloaden
  REPOSITORY="scripteBash_notizenUbuntu"
  ADRESSE="git@github.com:ju1-eu"
  git clone $ADRESSE/$REPOSITORY.git 

  # Backup Repository clonen
  repos_HD="/media/jan/virtuell/repos/notizenUbuntu"
  REPOSITORY="scripteBash_notizenUbuntu"
  git clone $repos_HD/$REPOSITORY.git 

  repos_USB="/media/jan/usb/repos/notizenUbuntu"    
  REPOSITORY="scripteBash_notizenUbuntu"
  git clone $repos_USB/$REPOSITORY.git 
~~~