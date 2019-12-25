#!/bin/bash -e
# Letztes Update: 6-Apr-2019
# tabellePDFs in Latex einfügen

# \usepackage{pdfpages}
# alle PDF Seiten im Querformat
#   \includepdf[landscape=true,pages=-]{tabelle.pdf}
# eine Seite pro Seite
#   \includepdf[landscape=true,pages={1}]{tabelle.pdf}
# zwei Seiten pro Seite: nup=<Anzahl der Spalten>x<Anzahl der Zeilen>
#   \includepdf[pages=-,nup= 1x2]{tabelle.pdf}

# Variable
#work=~/tex/projekt
tex="tex"
tabelle="Tabellen"
file=input-PDFs.txt # InputtabellePDFs.sh
archiv="archiv"
info="PDFs in Latex einfügen"
timestamp_2=$(date +"%d-%h-%Y")
copyright="ju - Letztes Update: $timestamp_2"

# --------------------------------
echo "+++ $info"
# File neu anlegen
printf "%% ---------------------------------\n"      >  $archiv/$file
printf "%% $info \n"                                 >> $archiv/$file
printf "%% $copyright\n"                             >> $archiv/$file
printf "%% ---------------------------------\n"      >> $archiv/$file
printf "%% \n"                                       >> $archiv/$file

#
cd $tabelle
for i in *.pdf; do
	# Dateiname ohne Endung
	pdfname=`basename "$i" .pdf`
	# zwei Seiten pro Seite: nup=<Anzahl der Spalten>x<Anzahl der Zeilen>
	printf "\section{$pdfname}\n"                                      >> ../$archiv/$file
	printf "%% -------\n"                                              >> ../$archiv/$file
	printf "\includepdf[scale=0.9, landscape=false,pages={1-1},nup=1x1,frame=false]{$tabelle/$i}\n\n"   >> ../$archiv/$file
done
cd ..

echo "fertig"
