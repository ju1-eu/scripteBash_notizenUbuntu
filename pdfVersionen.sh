#!/bin/bash -e
# letztes Update: 24-Dez-19
# PDF - Versionen erstellen

# ANPASSEN
pdfname="main-book"

# Variable
info="PDF - Versionen erstellen"
pdf=pdf
archiv="archiv"
content="content"
#dateiname ohne Endung
filename1=`basename "$pdfname" .pdf`
file="MD5-Hash.txt"
timestamp=$(date +"%Y-%h-%d_%H-%M")
timestamp_2=$(date +"%d-%h-%y")
timestamp_3=$(date +"%d%m%y")
copyright="letztes Update: $timestamp_2"

# ------------------------------
echo "+++ $info"

# git commit (hashwert)
ID="$(git rev-parse --short HEAD)"  # Version: v42c3f88
DATUM=$(date +"%Y/%m/%d")            # Datum: 2019/06/27
#echo "$DATUM - $ID"

cd $pdf/


# book
printf "# -------------------------------\n"   >  $file
printf "# PDF: 				    '$filename1'   \n"   >> $file
printf "# Datum: 			  	'$timestamp_2' \n"   >> $file

if [ ! -e "$filename1".pdf  ]; then echo "Fehler: '$filename1'.pdf nicht vorhanden."; exit; fi
# build - Versionen erstellen - 260619_main-book_v0b61478.pdf
fileVers=$timestamp_3'_'$filename1'_v_'$ID".pdf"
echo $fileVers
cp $filename1".pdf" $fileVers
echo $fileVers    >> $file
printf "\n# md5sum - Prüfsumme\n"           >> $file
#hashwert
md5sum $fileVers  >> $file

mv  $fileVers ../$archiv/
mv  $file ../$archiv/

cd ..

echo "fertig"
