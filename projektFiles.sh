#!/bin/bash -e
# Letztes Update: 6-Apr-2019
# Projekt files in Latex speichern

# Variable
#work=~/tex/projekt
code="scripteBash"     # bash files    *.sh
content="content"  # projekt files *.tex
file="Projekt-files.tex"
info="Projekt files in Latex speichern"
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

printf "\section{Projekt files}\n"                           >> $file
printf "%% ------\n\n"                                       >> $file

printf "\section{Bash - Scripte}\label{bashscripte}\n"       >> $file
printf "%% ------\n\n"                                       >> $file

# quellcode bash
# anpassen --------------------------------
cd $code
for i in *.sh; do
	# Dateiname ohne Endung
	scriptname=`basename "$i" .sh` # anpassen
  # latex quellcode
	printf "\subsection{$scriptname}\n"                                >> ../$file
	printf "%% ---------\n\n"                                          >> ../$file
	echo "(vgl. Code~\ref{code:$scriptname} $i).%--- Referenz"         >> ../$file
  printf "%%\n"                                                      >> ../$file
  printf "\lstinputlisting[language=Bash,caption={Bashscript: $i},label={code:$scriptname}\n"  >> ../$file
  printf "]{$code/$i}%% ext. file\n\n"                               >> ../$file
  echo "\newpage"                                                    >> ../$file
done

printf "\section{Latex}\label{latexscripte}\n"               >> ../$file
printf "%% ------\n\n"                                       >> ../$file

# quellcode Latex
# anpassen --------------------------------
cd ../$content
for i in *.tex; do
	# Dateiname ohne Endung
	scriptname=`basename "$i" .tex` # anpassen
  # latex quellcode
	printf "\subsection{$scriptname}\n"                                >> ../$file
	printf "%% ---------\n\n"                                          >> ../$file
	echo "(vgl. Code~\ref{code:$scriptname} $i).%--- Referenz"         >> ../$file
  printf "%%\n"                                                      >> ../$file
  printf "\lstinputlisting[language=TeX,caption={\LaTeX: $i},label={code:$scriptname}\n"  >> ../$file
  printf "]{$content/$i}%% ext. file\n\n"                               >> ../$file
  echo "\newpage"                                                    >> ../$file
done
cd ..

echo "fertig"
