#!/bin/bash -e
# letztes Update: 24-Dez-19
#
# Erstellt Websiten & \LaTeX PDFs mit Markdown und Pandoc.
# sed passt die \LaTeX-Syntax an.
# Versionsverwaltung: Git
#
# Projekt getestet unter Ubuntu 18.04.3 LTS
# 	$ lsb_release -a
# -------------------------------------------
# Shell
# Github Repository downloaden
#REPOSITORY="dummy-notizenUbuntu-v03"
#ADRESSE="git@github.com:ju1-eu"
#cd $REPOSITORY
#git clone $ADRESSE/$REPOSITORY.git .
	# oder
# Backup Repository clonen
#git clone /media/jan/virtuell/repos/notizenUbuntu/dummy-notizenUbuntu-v03.git .
#HD="/media/jan/virtuell/repos/notizenUbuntu"
#REPOSITORY="dummy-notizenUbuntu-v03"
#cd $REPOSITORY
#git clone $HD/$REPOSITORY.git .

# Script anpassen
# vi THEMA-umbenennen.sh
	# file: THEMA - Suchen und Ersetzen
# ./THEMA-umbenennen.sh
#
# Erste Schritte
#  $ cd neue-Notiz
# files anpassen
#scripte/sed.sh
#  - codelanguage:    HTML5, Python, Bash, C, C++, TeX
#  - CMS Server Pfad: https://www.ju1.eu/#
#  - Bildformat:      pdf, svg, png, jpg

#projekt.sh
#  - Backupverzeichnis

#content/metadata.tex
#  - Datum, Titel, Autor

#$ ./projekt.sh
  # Projekt erstellen"
# -------------------------------------------

# ANPASSEN
# script -> ../THEMA-umbenennen.sh
#------------------------------------------------------
	# anpassen
	THEMA="dummy-notizenUbuntu-v03"

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

# Variable
info="Projekt: Web & \LaTeX Dokumente erstellen unter Ubuntu"
scripte="scripteBash"
code="code"
img="images"
img_in="img-in"
img_out="img-out"
pdf="pdf"
md="md"
tex="tex"
tex_pandoc="tex-pandoc"
css="css"
html="html"
cms_lokal="cms-lokal"
cms_server="cms-server"
archiv="archiv"
content="content"
timestamp=$(date +"%Y-%h-%d")
timestamp_2=$(date +"%d-%h-%Y")
copyright="ju - Letztes Update: $timestamp_2"

# ---------------------------
janein=1
while [ "$janein" -eq 1 ]; do
	###clear
	printf "\n $info \n"
	printf "\n  0) Projekt erstellen."
	printf "\n  1) Markdown in (tex, html5) - sed (Suchen/Ersetzen)"
	printf "\n  2) Kopie tex (Pandoc) - tex (Handarbeit)"
	printf "\n  3) Kapitel erstellen, Scripte ausführen"
	printf "\n  4) Beamer"
	printf "\n  5) TEST: Artikel-PDFs erstellen mit latexmk (a_*.pdf)"
	printf "\n  6) PDFs erstellen (book-, print-, artikel.pdf) - Archiv (tex)"
	printf "\n  7) Projekt aufräumen"
	printf "\n  8) Git-Version erstellen"
	printf "\n  9) git status und git log --graph --oneline"
	printf "\n 10) git init"
	printf "\n 11) Fotos optimieren (Web, Latex)"
	printf "\n 12) book-pdf-Version erstellen"
	printf "\n 13) Backup (archiv/*.zip & *.tar.gz) & (/media/jan/virtuell/backup)"
	printf "\n 14) www"
	printf "\n 15) Beenden?"
	a=
	while [ -z "$a" ]; do
		printf "\n\n Eingabe Zahl >_ "
		read a
		# Zeichenketten eliminieren ,die Zeichen ausser 0-9  enthalten
		a=${a##*[^0-9]*}
		if [ -z "$a" ]; then
			echo "+++ Ungueltige Eingabe"
		fi
	done

	echo "--------------------------"
	printf "\n"

	# --------------------
	if [ $a -eq 0 ]; then
		# Projekt erstellen. ACHTUNG: git init bzw. rm -rf .git
		# Scriptaufruf
		./$scripte/projekterstellen.sh

	# --------------------
	elif [ $a -eq 1 ]; then
		# Markdown in (tex, html5) - sed (Suchen/Ersetzen)
		# Scriptaufruf
		./$scripte/markdownLatexHtml.sh
	  ./$scripte/sed.sh

  # --------------------
	elif [ $a -eq 2 ]; then
		# Kopie tex (Pandoc) - tex (Handarbeit)
		# -u	überspringt Dateien, die im Ziel neuer sind als in der Quelle
		rsync -a $tex_pandoc/ $tex

  # --------------------
	elif [ $a -eq 3 ]; then
		# Kapitel erstellen, Scripte ausführen
		# Scriptaufruf
		./$scripte/inputImgMarkdown.sh
		./$scripte/inputKapitelLatex.sh
		./$scripte/inputPdfsLatex.sh
		./$scripte/projektFiles.sh
		./$scripte/projektInhalt.sh
		./$scripte/codeFiles.sh

  # --------------------
	elif [ $a -eq 4 ]; then
		# Beamer
		./$scripte/datum-version.sh

		if [ `ls -a  tex | wc -l` -gt 2 ]; then
			# beamer
			dummybeamer="main-beamer-dummy.tex"
			#ls $content/$dummybeamer
			# schreibe in datei
			beamer="main-beamer"
			echo "% $copyright" > $beamer.tex
			cat $content/$dummybeamer >> $beamer.tex

			pdflatex $beamer.tex
			# Literatur
			#biber $beamer
			bibtex $beamer
			# Index
			#texindy -g --module ff-ranges-only $beamer.idx
			# IndexKonfig.xdy
			#xindy -L german-din -I latex --module IndexKonfig main-beamer.idx
			pdflatex $beamer.tex
			pdflatex $beamer.tex

			# Latex aufraeumen
			rm -f *~ *.aux *.bbl *.blg *.fls *.log *.nav *.out *.snm *.synctex *.toc \
				*.idx *.ilg *.ind *.thm *.lof *.lol *.lot *.nlo *.run.xml *blx.bib *.bcf
		else
			echo "Fehler: $tex leer; Schritt 1 bis 3 ausführen.";
		fi

  # --------------------
	elif [ $a -eq 5 ]; then
		# TEST: PDFs erstellen mit latexmk (a_*.pdf)
		./$scripte/datum-version.sh

		if [ `ls -a  tex | wc -l` -gt 2 ]; then
		  # artikel ohne Inhaltsverzeichnis
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
		    artikel="a_$basename.tex"
		    echo "% $copyright" > $artikel
		    cat $content/$dummyArtikel >> $artikel

       	# Kapitel: \input{inhalt}
        # suchen und ersetzen
        suchen_sed_reg="inhalt"
        ersetzen="$tex\/$basename"
        echo "Artikel - Kap. Suchen und Ersetzen..."
        sed -i "s/$suchen_sed_reg/$ersetzen/g" "$artikel"

		    # latexmk
		    latexmk -f -pdf a_$basename.tex
		  done

		  # Latex aufraeumen
		  rm -f *~ *.aux *.bbl *.blg *.fls *.log *.nav *.out *.snm *.synctex *.toc \
		    *.idx *.ilg *.ind *.thm *.lof *.lol *.lot *.nlo *.run.xml *blx.bib *.bcf

		  cp a_*.pdf  $pdf/
		else
		  echo "Fehler: $tex/ leer; Schritt 1 bis 3 ausführen.";
		fi

  # --------------------
	elif [ $a -eq 6 ]; then
		# PDFs erstellen (book-, print-, artikel.pdf) - Archiv (tex)
		./$scripte/datum-version.sh

		if [ `ls -a  tex | wc -l` -gt 2 ]; then
			# Scriptaufruf
			./$scripte/pdfErstellen.sh
		else
			echo "Fehler: $tex leer; Schritt 1 bis 3 ausführen.";
		fi

  # --------------------
	elif [ $a -eq 7 ]; then
		# Projekt aufräumen
		find . -name '*.aux' 2>/dev/null -exec rm -rf {}  +
		rm -rf *~  Projekt-files.tex Quellcode-files.tex inhalt.tex
		rm -rf main*.pdf
		rm -rf main*.tex
		rm -rf *.txt
		rm -rf a_*
		rm -rf index.html



		# löschen img_in u. img_out
		#if [ `ls -a  $img_in | wc -l` -gt 2 ]; then rm -rf $img_in/*; fi
		#if [ `ls -a  $img_out | wc -l` -gt 2 ]; then rm -rf $img_out/*; fi

		# löschen   tex/ tex-pandoc/  html/  html-wp/ img-in/ img-out/
		if [ -d $tex-pandoc ]; then rm -rf $tex_pandoc; fi
		if [ -d $tex ]; then rm -rf $tex; fi
		if [ -d $pdf ]; then rm -rf $pdf; fi
		if [ -d $archiv ]; then rm -rf $archiv; fi
		if [ -d $html ]; then rm -rf $html; fi
		if [ -d $cms_lokal ]; then rm -rf $cms_lokal; fi
		if [ -d $cms_server ]; then rm -rf $cms_server; fi
		if [ -d $img_in ]; then rm -rf $img_in; fi
		if [ -d $img_out ]; then rm -rf $img_out; fi

		# Latex aufraeumen
		if [ -e main-*.aux ]; then
			rm -rf *~ *.aux *.bbl *.blg *.fls *.log *.nav *.out *.snm *.synctex *.toc \
			  *.idx *.ilg *.ind *.thm *.lof *.lol *.lot *.nlo *.run.xml *blx.bib *.bcf *.synctex.gz
		fi

		echo "fertig"
	# --------------------
  elif [ $a -eq 8 ]; then
		# Git-Version (tex & md, ACHTUNG: wenn Projekt neu, dann git init bzw. rm -rf .git)
		# Scriptaufruf
		./$scripte/gitversionieren.sh

		# --------------------
	elif [ $a -eq 9 ]; then
		# git status und git log --graph --oneline
		git add .
		git status
		echo "# ----------------------------------------------"
		git log --graph --oneline
		echo "# ----------------------------------------------"

# --------------------
elif [ $a -eq 10 ]; then
		# git init
		rm -rf .git
		git init
		git add .
		git commit -m"Projekt init"
		git status
		echo "# ----------------------------------------------"
		git log --graph --oneline
		echo "# ----------------------------------------------"

	# --------------------
elif [ $a -eq 11 ]; then
		# Fotos optimieren (Web, Latex)
		# Scriptaufruf
		./$scripte/optiWebLatex.sh

	# --------------------
elif [ $a -eq 12 ]; then
		# PDF-Versionen erstellen
		# Scriptaufruf
		./$scripte/datum-version.sh
		./$scripte/pdfErstellen.sh
		./$scripte/pdfVersionen.sh

	# --------------------
elif [ $a -eq 13 ]; then
		echo "+++ Backup - Archiv - Netzwerk - USB"

		# Laufwerk vorhanden?
		if [ ! -d $backup_HD ]; then
		  echo "$backup_HD Laufwerk mounten."
		else
		  # backup 
		  rsync -a --delete ./ $backup_HD/$THEMA/
		fi

		# Laufwerk vorhanden?
		#if [ ! -d $backup_RPI4 ]; then
		#  echo "$backup_RPI4 Laufwerk mounten."
		#else
		#  # backup 
		#  rsync -a --delete ./ $backup_HD/$THEMA/
		#fi

		# Laufwerk vorhanden?
		if [ ! -d $backup_USB ]; then
		  echo "$backup_USB Laufwerk mounten."
		else
		  # backup 
		  rsync -a --delete ./ $backup_HD/$THEMA/
		fi

	  # archiv
		timestamp_3=$(date +"%d%m%y")
		ID=$(git rev-parse --short HEAD) # git commit (hashwert) = id
		
		tar cvzf $archiv_HD/$timestamp_3'_'$THEMA'_v'$ID.tgz .
		#tar cvzf $archiv_RPI4/$timestamp_3'_'$THEMA'_v'$ID.tgz .
		tar cvzf $archiv_USB/$timestamp_3'_'$THEMA'_v'$ID.tgz .

		#tar cvzf ../$timestamp_3'_'$THEMA'_v'$ID.tgz .
		#tar cvzf ../$THEMA.tgz .
	  #rm -rf ../$THEMA.zip
	  #zip -r ../$THEMA.zip .
		#rm -rf $archiv_ssd/$THEMA.zip
	  #zip -r $archiv_HD/$THEMA.zip .

		echo "# ----------------------------------------------"
	  echo "+ Archiv ($archiv_HD/)"
		echo "+ Backup ($backup_HD/)"
	  echo "+ Archiv ($archiv_USB/)"
		echo "+ Backup ($backup_USB/)"
		#echo "+ Archiv ($archiv_RPI4/)"
		#echo "+ Backup ($backup_RPI4/)"
		echo "# ----------------------------------------------"

		echo "fertig"

	# --------------------
	elif [ $a -eq 14 ]; then
		# www
		# Scriptaufruf
		./$scripte/www.sh

	# --------------------
	else
		echo "+++ $info"
		echo "fertig"; break
	fi
done
