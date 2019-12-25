#!/bin/bash -e
# Letztes Update: 6-Apr-2019
# Inhalt vom Projektverzeichnis

# Variable
#work=~/tex/projekt
file=Projekt-Inhalt.txt
archiv="archiv"
info="Inhalt vom Projektverzeichnis"
timestamp_2=$(date +"%d-%h-%Y")
copyright="ju - Letztes Update: $timestamp_2"

#  --------------------------------
echo "+++ $info"
# File neu anlegen
printf "%% ---------------------------------\n"      >  $archiv/$file
printf "%% $info\n"                                  >> $archiv/$file
printf "%% $copyright\n"                             >> $archiv/$file
printf "%% ---------------------------------\n"      >> $archiv/$file
printf "%% \n"                                       >> $archiv/$file

# Verzeichnissinhalt
ls -lath *  >> $archiv/$file

echo "fertig"
