#!/bin/bash -e
# letztes Update: 24-Dez-19
# index.html u. html/websiten erstellen

# Variable anpassen
THEMA="dummy-Notiz-Ubuntu-v03"
css="css/design.css"
cms_lokal="cms-lokal"
html="html"
pdf="pdf"
file="index.html"
img="images"

info="Websiten  erstellen"
timestamp=$(date +"%d-%h-%y")
copyright="letztes Update: $timestamp"

# ---------------------------------
echo "+ $info"

T1="<!DOCTYPE html>
<html><head>
	<meta charset=\"utf-8\"/>
	<title>$THEMA</title><!-- Titel u. Beschreibung anpassen-->
	<meta name=\"description\" content=\"Beschreibung\" />
	<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0, user-scalable=yes\" />
	<style type=\"text/css\">
		code{white-space: pre-wrap;}
		span.smallcaps{font-variant: small-caps;}
		span.underline{text-decoration: underline;}
		div.column{display: inline-block; vertical-align: top; width: 50%;}
	</style>"

# index.html
T2="	<link rel=\"stylesheet\" href=\"./$css\" />"
# html/website.html
T3="	<link rel=\"stylesheet\" href=\"../$css\" />"

T4="</head><body><!-- Inhalt -->"

T5="</body></html>"

# File neu anlegen
# index.html
echo "<!--$copyright-->"  > $file
echo "$T1"               >> $file
echo "$T2"               >> $file
echo "$T4"               >> $file
echo "	<h1>dummy-notizenUbuntu-v03</h1>
	<!-- Navi -->
	<ul class=\"nav\">"       >> $file


cd $cms_lokal
for i in *.html; do
	# Dateiname ohne Endung
	#filename=`basename "$i" .html` # anpassen

  # html/website.html
	echo "<!--$copyright-->" > ../$html/$i
	echo "$T1"              >> ../$html/$i
	echo "$T3"              >> ../$html/$i
	echo "$T4"              >> ../$html/$i
	echo "<p><a href=\"../$file\">Start</a></p>"  >> ../$html/$i
	cat $i                  >> ../$html/$i
	echo "$T5"              >> ../$html/$i
done
cd ..

echo "$html/xxx.html wurde erstellt"

#----------------------
# alle pics
pics="alle-pics.html"
echo "<!--$copyright-->"  > ./$html/$pics
echo "$T1"               >> ./$html/$pics
echo "$T3"               >> ./$html/$pics
echo "$T4"               >> ./$html/$pics
echo "	<p><a href=\"../$file\">Start</a></p>
	<h1>$THEMA</h1>
	<h2>alle Pics</h2>"    >> ./$html/$pics

cd $img
n=1 # Pic Zaehler
for i in *.jpg; do
	# Dateiname ohne Endung
	filename=`basename "$i" .jpg` # anpassen

	# html/alle-pics.html
	echo "	<!-- Abb. $n -->
	<p><a href=\"../$img/$i\">
	  <figure>
	    <img class=scaled src=\"../$img/$i\" alt=\"$filename\" width=\"100%\">
	    <figcaption>Abb. $n : $i</figcaption>
	  </figure>
	</a></p>" >> ../$html/$pics
	((n+=1))
done

for i in *.svg; do
	# Dateiname ohne Endung
	filename=`basename "$i" .svg` # anpassen

	# html/alle-pics.html
	echo "	<!-- Abb. $n -->
	<p><a href=\"../$img/$i\">
	  <figure>
	    <img class=scaled src=\"../$img/$i\" alt=\"$filename\" width=\"100%\">
	    <figcaption>Abb. $n : $i</figcaption>
	  </figure>
	</a></p>" >> ../$html/$pics
	((n+=1))
done

echo "$html/alle-pics.html wurde erstellt"

for i in *.pdf; do
	# Dateiname ohne Endung
	filename=`basename "$i" .pdf` # anpassen

	# html/alle-pics.html
	echo "	<!-- Abb. $n -->
	<p><a href=\"../$img/$i\">
	  <figure>
	    <figcaption>Abb. $n : $i</figcaption>
	  </figure>
	</a></p>" >> ../$html/$pics
	((n+=1))
done

cd ..

echo "$T5"     >> ./$html/$pics

#----------------------
# alle pdfs
pdfs="alle-pdfs.html"
echo "<!--$copyright-->"  > ./$html/$pdfs
echo "$T1"               >> ./$html/$pdfs
echo "$T3"               >> ./$html/$pdfs
echo "$T4"               >> ./$html/$pdfs
echo "	<p><a href=\"../$file\">Start</a></p>
	<h1>$THEMA</h1>
	<h2>alle PDFs</h2>
	<ul class=\"nav\">"    >> ./$html/$pdfs

cd $pdf
for i in *.pdf; do
	# Dateiname ohne Endung
	#filename=`basename "$i" .pdf` # anpassen

	# html/alle-pdfs.html
	echo "		<li><a href=\"../$pdf/$i\">$i</a></li>"  >> ../$html/$pdfs
done

cd ..

echo "	</ul>" >> ./$html/$pdfs
echo "$T5"     >> ./$html/$pdfs

echo "$html/alle-pdfs.html wurde erstellt"

# -------------------------
# index.html
cd $html
for i in *.html; do
	# Dateiname ohne Endung
	#filename=`basename "$i" .html` # anpassen

	# navi - index.html
	echo "		<li><a href=\"./$html/$i\">$i</a></li>"  >> ../$file
done
cd ..

echo "	</ul>" >> $file
echo "$T5"     >> $file

echo "index.html wurde erstellt"

echo "fertig"
