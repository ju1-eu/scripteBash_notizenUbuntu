#!/bin/bash -e
# Letztes Update: 6-Apr-2019
# Projekt files in Latex speichern

# Variable anpassen
codelanguage="Bash"  # HTML5, Python, Bash, C, C++, TeX
fileende="sh"        # html, sh, c, cpp, py, tex
code="code"     # quellcode
file="Quellcode-files.tex"
info="Quellcode in Latex speichern"
timestamp_2=$(date +"%d-%h-%Y")
copyright="ju - Letztes Update: $timestamp_2"

# ---------------------------------
echo "+++ $info"

# File neu anlegen
printf "%% ---------------------------------\n"              >  $file
printf "%% $info \n"                                         >> $file
printf "%% $copyright\n"                                     >> $file
printf "%% ---------------------------------\n"              >> $file
printf "%%\n"                                                >> $file

printf "\section{Quellcode}\label{quellcode}\n"       >> $file
printf "%% ------\n\n"                                       >> $file

# quellcode bash
# anpassen --------------------------------
cd $code
for i in *.$fileende; do
	# Dateiname ohne Endung
	scriptname=`basename "$i" .$fileende` # anpassen
  # latex quellcode
	printf "\subsection{$scriptname}\n"                                >> ../$file
	printf "%% ---------\n\n"                                          >> ../$file
	echo "(vgl. Code~\ref{code:$scriptname} $i).%--- Referenz"         >> ../$file
  printf "%%\n"                                                      >> ../$file
  printf "\lstinputlisting[language=$codelanguage,caption={Quellcode in $codelanguage: $i},label={code:$scriptname}\n"  >> ../$file
  printf "]{$code/$i}%% ext. file\n\n"                               >> ../$file
  echo "\newpage"                                                    >> ../$file
done

cd ..

echo "fertig"
