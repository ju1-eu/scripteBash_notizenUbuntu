#!/bin/bash -e
# Letztes Update: 25-Dez-19

# alte Notizen nach neue Notizen kopieren
# Repository dummy-notizenUbuntu-v03

# ----------------------------------------------
    # Ordner 'neu/' erstellen"
    # Repository 'dummy-notizenUbuntu-v03' clonen"
    # THEMA: suchen und ersetzen"
    # Kopie von wichtigen VERZEICHNISSEN"
    # Projekt erstellen - Markdown -> html + LaTeX - Suchen und Ersetzen"
    # git init - neues Repository erstellen"
    # PDF Datum - Version setzen"
    # PDFs erstellen"
    # Websiten erstellen"
    # Git - Versionieren"
    # Backup"
    # Archiv"
# ----------------------------------------------

# Github Repository downloaden
# ----------------------------
# Github Repository downloaden
#  REPOSITORY="dummy-notizenUbuntu-v03"
#  ADRESSE="git@github.com:ju1-eu"
#  git clone $ADRESSE/$REPOSITORY.git 

  # Backup Repository clonen
#  repos_HD="/media/jan/virtuell/repos/notizenUbuntu"
#  REPOSITORY="dummy-notizenUbuntu-v03"
#  git clone $repos_HD/$REPOSITORY.git 

#  repos_USB="/media/jan/usb/repos/notizenUbuntu"    
#  REPOSITORY="dummy-notizenUbuntu-v03"
#  git clone $repos_USB/$REPOSITORY.git 

clear

# variablen

#-----------------------------------------------------------------------
  # Logik:  ja = 1, nein = 0
  GIT_TRUE=1            # git versionieren ?
  NEUE_NOTIZEN_TRUE=1     # gibt es neue Notizen?
  REPOSITORY_dummy_TRUE=1 # Backup Repository erstellen?
  GIT_Vers_TRUE=1        # git versionen anlegen?
  ARCHIV_TRUE=1         # archivieren ?
  BACKUP_HD_TRUE=1      # backup auf HD anlegen ?
  BACKUP_USB_TRUE=1     # backup auf USB anlegen ?
  #BACKUP_RPI4_TRUE=1    # backup auf RPI$ anlegen ?
#-----------------------------------------------------------------------

# Backup
#------------------------------------------------------
  # anpassen
  #THEMA="neuNotiz???"
  REPOSITORY="dummy-notizenUbuntu-v03"

  backup_USB="/media/jan/usb/backup/notizenUbuntu"    
  #backup_RPI4="smb://rpi4.local/nas/backup/notizenUbuntu" 
  backup_HD="/media/jan/virtuell/backup/notizenUbuntu"

  archiv_USB="/media/jan/usb/archiv/notizenUbuntu"    
  #archiv_RPI4="smb://rpi4.local/nas/archiv/notizenUbuntu" 
  archiv_HD="/media/jan/virtuell/archiv/notizenUbuntu"

  repos_USB="/media/jan/usb/repos/notizenUbuntu"    
  #repos_RPI4="smb://rpi4.local/nas/repos/notizenUbuntu" 
  repos_HD="/media/jan/virtuell/repos/notizenUbuntu"
#------------------------------------------------------

work="/home/jan/tex"
alt="alt"
neu="neu"
archiv="archiv"

# Kopie von wichtigen VERZEICHNISSEN
code="code"
img="images"
md="md"
tex="tex"
tabellen="Tabellen"
work_files="work_files"
grafiken="Grafiken"

# projekt erstellen
scripte="scripteBash_notizenUbuntu"
tex_pandoc="tex-pandoc"
tex="tex"
pdf="pdf"
content="content"

TIMESTAMP=$(date +"%d-%h-%y")

echo "+----------------------------------------"
echo "+ alte Notizen nach neue Notizen kopieren"
echo "+----------------------------------------"

#cd $work

#if [ ! -d ./$archiv ]; then mkdir -p ./$archiv; fi

# Ordner neu erstellen
#----------------------------------------------------
# Ordnername in liste.txt speichern
ls $alt | sort > $work/liste.txt
# liste.txt zeilenweise lesen
while read ordnername; do
  #echo "$ordnername";
  THEMA=$ordnername
  if [ ! -d ./$neu/$THEMA ]; then mkdir -p ./$neu/$THEMA; fi
done < $work/liste.txt

# "Repository 'dummy-notizenUbuntu-v03' vorhanden?"
#----------------------------------------------------
# liste.txt zeilenweise lesen
while read ordnername; do
  #echo "$ordnername";
  THEMA=$ordnername
  if [ -d $neu/$THEMA ]; then rm -rf $neu/$THEMA; fi
  echo "Repository clonen"
  git clone $repos_HD/$REPOSITORY.git $neu/$THEMA/
done < $work/liste.txt

# THEMA: suchen und ersetzen
#----------------------------------------------------
# liste.txt zeilenweise lesen
while read ordnername; do
  #echo "$ordnername";
  THEMA=$ordnername
  echo "#---------------------"
  # suchen und ersetzen
  folder="$THEMA"
  suchen="$REPOSITORY"
  suchen_sed_reg="$REPOSITORY" # sed  https:\/\/bw1.eu
  ersetzen="$THEMA"
  echo "Suche: $suchen -> Ersetze: $ersetzen"  
  # Suche vorher
  printf "Suchtreffer vorher: "
  grep -r $suchen $neu/$folder/ |wc -l
  echo "Verarbeitung beginnt..."
  find $neu/$folder/ -type f -print0 | xargs -0 sed -i -e "s/$suchen_sed_reg/$ersetzen/g"
  # Suche nachher
  printf "Suchtreffer nachher: "
  grep -r $suchen $neu/$folder/|wc -l
done < $work/liste.txt


# Kopie von wichtigen VERZEICHNISSEN
#----------------------------------------------------
# liste.txt zeilenweise lesen
while read ordnername; do
  #echo "$ordnername";
  THEMA=$ordnername
  rsync -a $work/$alt/$THEMA/$code/ $work/$neu/$THEMA/$code/
  rsync -a $work/$alt/$THEMA/$img/ $work/$neu/$THEMA/$img/
  rsync -a $work/$alt/$THEMA/$md/ $work/$neu/$THEMA/$md/
  rsync -a $work/$alt/$THEMA/$tex/ $work/$neu/$THEMA/$tex/
  rsync -a $work/$alt/$THEMA/$work_files/ $work/$neu/$THEMA/$work_files/
  rsync -a $work/$alt/$THEMA/$grafiken/ $work/$neu/$THEMA/$grafiken/
  rsync -a $work/$alt/$THEMA/$tabellen/ $work/$neu/$THEMA/$tabellen/
  echo "#----rsync $ordnername fertig"
done < $work/liste.txt


# projekt 
#----------------------------------------------------
cd $neu/
# liste.txt zeilenweise lesen
ls
while read ordnername; do
  #echo "$ordnername";
  THEMA=$ordnername
  echo "#-----$ordnername"
  cd ./$THEMA

  # projekt erstellen
  if [ $NEUE_NOTIZEN_TRUE -eq 1 ]; then
    # Scriptaufruf  
    $work/$scripte/projekterstellen.sh
    $work/$scripte/markdownLatexHtml.sh
    $work/$scripte/sed.sh
    rsync -a $tex_pandoc/ $tex
    $work/$scripte/inputImgMarkdown.sh
    $work/$scripte/inputKapitelLatex.sh
    $work/$scripte/inputPdfsLatex.sh
    $work/$scripte/projektFiles.sh
    $work/$scripte/projektInhalt.sh
    $work/$scripte/codeFiles.sh

    # Websiten
    $work/$scripte/www.sh
  fi
  # Git Version
  #----------------------------------------------------
  #repos_USB="/media/jan/usb/repos/notizenUbuntu"    
  #repos_RPI4="smb://rpi4.local/nas/repos/notizenUbuntu" 
  #repos_HD="/media/jan/virtuell/repos/notizenUbuntu"
  #----------------------------------------------------
  if [ $GIT_TRUE -eq 1 ]; then
    if [ -d .git ]; then rm -rf .git; fi
    git init
    git add .
    git commit -m"Projekt init"
    echo "$THEMA/ git init"

    # Backup Repository: backup/master
    if [ $REPOSITORY_dummy_TRUE -eq 1 ]; then
      # "Backup Repository $THEMA erstellen?"
      REPOSITORY_NEU="$THEMA"
      LESEZEICHEN="backupHD"
      if [ -d $repos_HD/$REPOSITORY_NEU.git ]; then rm -rf $repos_HD/$REPOSITORY_NEU.git; fi
      git clone --no-hardlinks --bare . $repos_HD/$REPOSITORY_NEU.git
      git remote add $LESEZEICHEN $repos_HD/$REPOSITORY_NEU.git
      git push --all $LESEZEICHEN
      echo "Backup Repository auf HD erstellt"

      #REPOSITORY_NEU="$THEMA"
      LESEZEICHEN="backupUSB"
      if [ -d $repos_USB/$REPOSITORY_NEU.git ]; then rm -rf $repos_USB/$REPOSITORY_NEU.git; fi
      git clone --no-hardlinks --bare . $repos_USB/$REPOSITORY_NEU.git
      git remote add $LESEZEICHEN $repos_USB/$REPOSITORY_NEU.git
      git push --all $LESEZEICHEN
      echo "Backup Repository USB erstellt"

      #if [ -d $repos_RPI4/$REPOSITORY_NEU.git ]; then
      #    rm -rf $repos_RPI4/$REPOSITORY_NEU.git
      #fi
      #git clone --no-hardlinks --bare . $repos_RPI4/$REPOSITORY_NEU.git
      #LESEZEICHEN="backupRPI4"
      #git remote add $LESEZEICHEN $repos_RPI4/$REPOSITORY_NEU.git
      #git push --all $LESEZEICHEN
      #echo "Backup Repository RPI4 erstellt"
    fi

    # PDFs book + Artikel erstellen (book.pdf) - Archiv (tex)
    if [ -d $tex ]; then 
      if [ `ls -a  $tex | wc -l` -gt 2 ]; then
        $work/$scripte/datum-version.sh

        # PDFs book + Artikel erstellen mit latexmk
        # artikel
        array=$(ls $tex)
        #echo "$array"
        dummyArtikel="main-artikel-dummy.tex"

        #Array lesen
        for a in ${array[@]}; do
          # filename: file.tex
          #echo $a
          # basename: file
          #echo ${a%.*}
          basename=${a%.*}
          # schreibe jeweils in datei
          artikel="$basename.tex"
          echo "% %TIMESTAMP" > $artikel
          cat $content/$dummyArtikel >> $artikel

          # Kapitel: \input{inhalt}
          # suchen und ersetzen
          suchen_sed_reg="inhalt"
          ersetzen="$tex\/$basename"
          echo "Artikel - Kap. Suchen und Ersetzen..."
          sed -i "s/$suchen_sed_reg/$ersetzen/g" "$artikel"

          # latexmk
          latexmk -f -pdf $basename.tex
          cp $basename.pdf  $pdf/
        done

        # book
        dummyBook="main-book-dummy.tex"
        #ls $content/$dummyBook
        # schreibe in datei
        book="main-book"
        echo "% %TIMESTAMP" > $book.tex
        cat $content/$dummyBook >> $book.tex
        latexmk -f -pdf  $book.tex
        cp $book.pdf  $pdf/

        echo "pdfVersionen.sh"
        #$work/$scripte/pdfErstellen.sh
        $work/$scripte/pdfVersionen.sh

        # Latex aufraeumen
        rm -f *~ *.aux *.bbl *.blg *.fls *.log *.nav *.out *.snm *.synctex *.toc \
          *.idx *.ilg *.ind *.thm *.lof *.lol *.lot *.nlo *.run.xml *blx.bib *.bcf


      else
        echo "Fehler: $tex leer";
      fi
    fi
    
  fi
  # Git Version
  #----------------------------------------------------
  #repos_USB="/media/jan/usb/repos/notizenUbuntu"    
  #repos_RPI4="smb://rpi4.local/nas/repos/notizenUbuntu" 
  #repos_HD="/media/jan/virtuell/repos/notizenUbuntu"
  #----------------------------------------------------
  if [ $GIT_Vers_TRUE -eq 1 ]; then
    # lokales Repository: HEAD -> master
    git add .
    git commit -m"PDF - Websiten erstellt" # editor
    #git branch
    # Branch neu erstellen
    git checkout -b feature/a1
    # Feature-Branch zentral sichern
    #git push --set-upstream origin feature/a1
    # Änderungen können zukünftig gesichert werden
    #git push
    # Branch wechseln
    #git status 
    #git branch
    git checkout master

    # Branch zusammenführen
    #git merge feature/a1

    #git branch
    # nutzlosen Branch löschen
    #git push -d origin feature/a1
    #git branch -d feature/a1

    #git tag
    git tag v1.0 # release

    

    # Backup Repository: backup/master  
    REPOSITORY_NEU="$THEMA"
    if [ -d $repos_HD/$REPOSITORY_NEU.git ]; then
        LESEZEICHEN="backupHD"
        git push --all $LESEZEICHEN
        echo "Backup Repository auf HD"
    fi

    if [ -d $repos_USB/$REPOSITORY_NEU.git ]; then
        LESEZEICHEN="backupUSB"
        git push --all $LESEZEICHEN
        echo "Backup Repository auf USB"
    fi

    #if [ -d $repos_RPI4/$REPOSITORY_NEU.git ]; then
    #    LESEZEICHEN="backupRPI4"
    #    git push --all $LESEZEICHEN
    #    echo "Backup Repository auf RPI4"
    #fi

    echo "update: $TIMESTAMP" > git.log
    echo "+----------------------------------------" >> git.log
    git lg >> git.log
    echo "+----------------------------------------" >> git.log
    git status >> git.log
    echo "+----------------------------------------" >> git.log
    
  fi
 

  # Backup 
  #-------------------------------------------------------
  #backup_USB="/media/jan/usb/backup/notizenUbuntu"    
  #backup_RPI4="smb://rpi4.local/nas/backup/notizenUbuntu" 
  #backup_HD="/media/jan/virtuell/backup/notizenUbuntu"
  #-------------------------------------------------------
  if [ $BACKUP_USB_TRUE -eq 1 ]; then
    echo "+ Backup (USB)"
    # Speicher - Laufwerk vorhanden?
    if [ ! -d $backup_USB ]; then
      echo "$backup_USB mounten."
    else
      # backup 
      rsync -a --delete ./ $backup_USB/$THEMA/
      echo "+ Backup ($backup_USB/$THEMA/)"
    fi
  fi

  if [ $BACKUP_HD_TRUE -eq 1 ]; then
    echo "+ Backup (HD)"
    # Speicher - Laufwerk vorhanden?
    if [ ! -d $backup_HD ]; then
      echo "$backup_HD mounten."
    else
      # backup extern
      rsync -a --delete ./ $backup_HD/$THEMA/
      echo "+ Backup ($backup_HD/$THEMA/)"
    fi
  fi

  #if [ $BACKUP_RPI4_TRUE -eq 1 ]; then
    #echo "+ Backup (RPI4)"
    # Speicher - Laufwerk vorhanden?
    #if [ ! -d $backup_RPI4 ]; then
    #  echo "$backup_RPI4 mounten."
    #else
    #  # backup 
    #  rsync -a --delete ./ $backup_RPI4/$THEMA/
    #  echo "+ Backup ($backup_RPI4/$THEMA/)"
    #fi
  #fi  


    


  # Archiv 
  #-------------------------------------------------------
  #archiv_USB="/media/jan/usb/archiv/notizenUbuntu"    
  #archiv_RPI4="smb://rpi4.local/nas/archiv/notizenUbuntu" 
  #archiv_HD="/media/jan/virtuell/archiv/notizenUbuntu"
  #-------------------------------------------------------
  if [ $ARCHIV_TRUE -eq 1 ]; then
    echo "+ Archiv erstellen"

    timestamp_3=$(date +"%d%m%y")
    ID=$(git rev-parse --short HEAD) # git commit (hashwert) = id

    # 010719_THEMA_v080fed9.tgz
    tar cvzf $archiv_HD/$timestamp_3'_'$THEMA'_v_'$ID.tgz .
    tar cvzf $archiv_USB/$timestamp_3'_'$THEMA'_v_'$ID.tgz .
    #tar cvzf $archiv_RPI$/$timestamp_3'_'$THEMA'_v_'$ID.tgz .

    echo "+ Archiv ($archiv_HD/) fertig."
    echo "+ Archiv ($archiv_USB/) fertig."
    #echo "+ Archiv ($archiv_RPI4/) fertig."
  fi

  cd ..
done < $work/liste.txt
cd ..


 echo "# ----------------------------------------------"
 echo "+ Ordner 'neu/' erstellen"
 echo "+ Repository clonen"
 echo "+ THEMA: suchen und ersetzen"
 echo "+ Kopie von wichtigen VERZEICHNISSEN"
 echo "+ Projekt erstellen - Markdown -> html + LaTeX - Suchen und Ersetzen"
 echo "+ git init - neues Repository erstellen"
 echo "+ PDF Datum - Version setzen"
 echo "+ PDFs erstellen"
 echo "+ Websiten erstellen"
 echo "+ Git - Versionieren"
 echo "+ Backup"
 echo "+ Archiv"
 echo "# ----------------------------------------------"
 echo "rsync -a alt/ neu/"
 echo "# ----------------------------------------------"

echo "Script beendet."
