#!/bin/bash -e
# letztes Update: 24-Dez-19
# Projekt erstellen

# Variable
info="Projekt erstellen"
img_in="img-in"
img_out="img-out"
pdf="pdf"
tex_pandoc="tex-pandoc"
tex="tex"
html="html"
cms_lokal="cms-lokal"
cms_server="cms-server"
archiv="archiv"

# ----------------------------
echo "+++ $info"

echo "+++ Verz. erstellen, wenn nicht vorhanden"
if [ ! -d ./$html ];            then mkdir -p ./$html; fi
if [ ! -d ./$cms_lokal ];       then mkdir -p ./$cms_lokal; fi
if [ ! -d ./$cms_server ];      then mkdir -p ./$cms_server; fi
if [ ! -d ./$pdf ];             then mkdir -p ./$pdf; fi
if [ ! -d ./$tex ];             then mkdir -p ./$tex; fi
if [ ! -d ./$tex_pandoc ];      then mkdir -p ./$tex_pandoc; fi
if [ ! -d ./$img_in ];          then mkdir -p ./$img_in; fi
if [ ! -d ./$img_out ];         then mkdir -p ./$img_out; fi
if [ ! -d ./$archiv ];          then mkdir -p ./$archiv; fi

echo "fertig"
