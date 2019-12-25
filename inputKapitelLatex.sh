#!/bin/bash -e
# Letztes Update: 14-Apr-2019
# Latex Kapitel *.tex

# Latex
#   \chapter{Kapitel}
#   \input{tex/Kapitel}

# Variable
#work=~/tex/projekt
tex="tex"
file="inhalt.tex"
info="Latex Kapitel"
timestamp_2=$(date +"%d-%h-%Y")
copyright="ju - Letztes Update: $timestamp_2"

#  --------------------------------
echo "+++ $info"
# File neu anlegen
printf "%% ---------------------------------\n"      >  $file
printf "%% $info \n"                                 >> $file
printf "%% $copyright\n"                             >> $file
printf "%% ---------------------------------\n"      >> $file
printf "%%\n"                                        >> $file


# book - print
cd $tex
for i in *.tex; do
	# dateiname ohne Endung
	texname=`basename "$i" .tex`
	# \chapter{Kapitel}
  # \input{Kapitelname}
	printf "%%\chapter{$texname}\n"               >> ../$file
	printf "\input{$tex/$texname}\n"              >> ../$file
	printf "\clearpage\n"                         >> ../$file
done

printf "%%\chapter{Quellcode-files}\n"          >> ../$file
printf "%%\input{Quellcode-files}\n"            >> ../$file
printf "%%\clearpage\n"                         >> ../$file

printf "%%\chapter{Projekt-files}\n"            >> ../$file
printf "%%\input{Projekt-files}\n"              >> ../$file
printf "%%\clearpage\n"                         >> ../$file

cd ..

echo "fertig"
