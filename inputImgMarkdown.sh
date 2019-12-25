#!/bin/bash -e
# letztes Update: 24-Dez-19
# Bilder in Markdown einfügen

# Markdown
# (siehe pic. bildname.)
# ![bildname](images/bildname.pdf)

# Variable
#work=~/tex/projekt
file=input-img.txt
img="images"
archiv="archiv"
info="Bilder in Markdown einfügen"
# Zeit
timestamp=$(date +"%Y-%h-%d_%H:%M")
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
cd $img
for i in *.pdf; do
	# dateiname ohne Endung
	picname=`basename "$i" .pdf`
	# ![bildname](images/bildname.pdf)
	printf "![$picname]($img/$i)\n\n"           >> ../$archiv/$file
done
cd ..

echo "fertig"
