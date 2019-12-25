#!/bin/bash -e
# letztes Update: 24-Dez-19

# suchen und ersetzen: sed -i '/suchen/ s//ersetzen/g' "$i"
# loeschen:            sed -i '/suchen/d' "$i"


# ANPASSEN
codelanguage="Bash"      # HTML5, Python, Bash, C, C++, TeX

# CMS
# Server Pfad anpassen Zeile 80
# https://www.ju1.eu/#
PFAD_SERVER="https:\/\/www.ju1.eu\/#"
PFAD_LOKAL="..\/images"

# Bildformat:  pdf, svg, png, jpg, webp
bildformat="jpg"

# Variable
tex_pandoc="tex-pandoc"
cms_lokal="cms-lokal"
cms_server="cms-server"

strich="%+------------------------------------------------------------------------"

timestamp=$(date +"%d-%h-%y")


#+-------------------
echo "+++ sed - Wordpress"
cd $cms_lokal
for i in *.html; do
	# suchen und ersetzen: sed -i '/suchen/ s//ersetzen/g' "$i"
	# loeschen:  sed -i '/suchen/d' "$i"
	#sed -i '/---/ s//-/g' "$i"
	#sed -i 's/<embed/<img/g' "$i"
	#sed -i '/"images/ s//"..\/images/g' "$i"
	sed -i '/<figure>/ s//<!-- Muster: Link auf Bild \n<p><a href="'$PFAD_LOKAL'\/bildname.'$bildformat'"> \n	<figure> \n		<img class=scaled src="'$PFAD_LOKAL'\/bildname.'$bildformat'" alt="bildname" width="100%"> \n		<figcaption>Abb. : bildname.'$bildformat'<\/figcaption> \n<\/figure><\/a><\/p> \n--> \n<figure>/g' "$i"
	sed -i '/.pdf/ s//.'$bildformat'/g' "$i"
	sed -i '/\/><figcaption>/ s//alt="bildname" width="100%"> \n	<figcaption>Abb. : /g' "$i"
	sed -i 's/<embed/	<!--Link auf Bild anpassen-->/g' "$i"
	sed -i 's/src="images/\n	<img class=scaled src="'$PFAD_LOKAL'/g' "$i"



	#sed -i '/ / s// /g' "$i"
	sed -i '/”/ s//\&laquo;/g' "$i"
	sed -i '/“/ s//\&raquo;/g' "$i"
done

cd ../$cms_server
for i in *.html; do
	# suchen und ersetzen: sed -i '/suchen/ s//ersetzen/g' "$i"
	# loeschen:  sed -i '/suchen/d' "$i"
	#sed -i '/---/ s//-/g' "$i"
	#sed -i 's/<embed/<img/g' "$i"
	#sed -i '/"images/ s//"..\/images/g' "$i"
	sed -i '/<figure>/ s//<!-- Muster: Link auf Bild \n<p><a href="'$PFAD_SERVER'\/bildname.'$bildformat'"> \n	<figure> \n		<img class=scaled src="'$PFAD_SERVER'\/bildname.'$bildformat'" alt="bildname" width="100%"> \n		<figcaption>Abb. : bildname.'$bildformat'<\/figcaption> \n<\/figure><\/a><\/p> \n--> \n<figure>/g' "$i"
	sed -i '/.pdf/ s//.'$bildformat'/g' "$i"
	sed -i '/\/><figcaption>/ s//alt="bildname" width="100%"> \n	<figcaption>Abb. : /g' "$i"
	sed -i 's/<embed/	<!--Link auf Bild anpassen-->/g' "$i"
	sed -i 's/src="images/\n	<img class=scaled src="'$PFAD_SERVER'/g' "$i"

	#sed -i '/ / s// /g' "$i"
	sed -i '/”/ s//\&laquo;/g' "$i"
	sed -i '/“/ s//\&raquo;/g' "$i"
done

#+-------------------
echo "+++ sed - Latex"
cd ../$tex_pandoc
for i in *.tex; do
	# Abbildung
	# suchen und ersetzen: sed -i '/suchen/ s//ersetzen/g' "$i"
	# loeschen:  sed -i '/suchen/d' "$i"
	sed -i '/\\hypertarget/d' "$i"
	sed -i '/}}/ s//}/g' "$i"
	sed -i '/\\caption/d' "$i"
	sed -i '/\\begin{figure}/ s//%Bild (siehe Abb. \\ref{fig:}). \n\\begin{figure}[H]% hier: htbp/g' "$i"
	sed -i '/\\includegraphics/ s/$/\n	'$strich'\n	%\\caption{}%\\label{fig:}% /g' "$i"
	sed -i '/\\centering/ s//	\\centering/g' "$i"
	sed -i '/\\includegraphics/ s//	\\includegraphics[width=.55\\textwidth]/g' "$i"

	# Tabellen
	# suchen und ersetzen: sed -i '/suchen/ s//ersetzen/g' "$i"
	# loeschen:  sed -i '/suchen/d' "$i"
	sed -i '/\\strut/ s///g' "$i"
	sed -i '/\\end{minipage}/ s///g' "$i"
	sed -i '/@{}/ s///g' "$i"
  sed -i '/\[c\]/ s///g' "$i"
	sed -i '/\\begin{longtable}/ s// \\begin{tabular} /g' "$i"
	sed -i '/\\endhead/d' "$i"
  sed -i '/\\begin{tabular}/ s//%Tabelle (vgl. Tab. \\ref{tab:}). \n	\\begin{table}[H]% hier: htbp \n	\\centering \n	\\arrayrulecolor{lightgray} \n	\\sffamily\\footnotesize \n	\\begin{tabular}/g' "$i"
	sed -i '/\\begin{tabular}/ s/$/@{}}/g' "$i"
	sed -i '/ [[]]{/ s//{@{}/g' "$i"
	sed -i '/\\toprule/ s//	\\toprule /g' "$i"
	sed -i '/tabularnewline/ s//\\/g' "$i"
	sed -i '/\\midrule/ s//	\\midrule/g' "$i"
	sed -i '/\\bottomrule/ s//	\\bottomrule\n \\end{tabular}%/g' "$i"
	sed -i '/\\end{longtable}/ s//	'$strich'\n	%\\caption{}%\\label{tab:}% \n\\end{table}/g' "$i"

	# Loeschen
	# suchen und ersetzen: sed -i '/suchen/ s//ersetzen/g' "$i"
	# loeschen:  sed -i '/suchen/d' "$i"
	sed -i '/\\begin{minipage}/d' "$i"
	sed -i '/\\strut\\end{minipage}/ s///g' "$i"

	# Quellcode
	# suchen und ersetzen: sed -i '/suchen/ s//ersetzen/g' "$i"
	# loeschen:  sed -i '/suchen/d' "$i"
	sed -i '/\\begin{verbatim}/ s//%Quellcode (vgl. Quellcode \\ref{code:}). \n\\begin{lstlisting}[language='$codelanguage',% C, C++, TeX, Bash, Python \n'$strich'\n%caption={Quellcode in '$codelanguage': },%label={code:}% \n]%--Code einfügen--% \n/g' "$i"
	sed -i '/\\end{verbatim}/ s//\\end{lstlisting}/g' "$i"


	# Literaturangaben
	# suchen und ersetzen: sed -i '/suchen/ s//ersetzen/g' "$i"
	# loeschen:  sed -i '/suchen/d' "$i"
	sed -i '/siehe lit./ s/$/}.	%% Literaturangabe/g' "$i"
	sed -i '/siehe lit. / s//siehe~\\cite{/g' "$i"

	# listen
	# suchen und ersetzen: sed -i '/suchen/ s//ersetzen/g' "$i"
	# loeschen:  sed -i '/suchen/d' "$i"
	sed -i '/\\tightlist/d' "$i"
	sed -i '/\\def\\labelenumi{\\arabic{enumi}.}/d' "$i"
	sed -i '/\\begin{itemize}/ s//\\begin{itemize}% Liste Punkt/g' "$i"
	sed -i '/\\end{itemize}/ s//\\end{itemize}/g' "$i"
	sed -i '/\\begin{enumerate}/ s//\\begin{enumerate}% Liste 1) oder a)/g' "$i"
	sed -i '/\\end{enumerate}/ s//\\end{enumerate}/g' "$i"

	# Fileanfang
	# suchen und ersetzen: sed -i '/suchen/ s//ersetzen/g' "$i"
	# loeschen:  sed -i '/suchen/d' "$i"
	sed -i '1i% letztes Update: '$timestamp'' "$i"


	# Umlaute im Label
	# suchen und ersetzen: sed -i '/suchen/ s//ersetzen/g' "$i"
	# loeschen:  sed -i '/suchen/d' "$i"
	sed -i '/uxfc/ s//ue/g' "$i"
	sed -i '/uxf6/ s//oe/g' "$i"
	sed -i '/uxe4/ s//ae/g' "$i"
	sed -i '/uxdf/ s//ss/g' "$i"
	sed -i '/---/ s//-/g'   "$i"

	# Mathe
	# suchen und ersetzen: sed -i '/suchen/ s//ersetzen/g' "$i"
	# loeschen:  sed -i '/suchen/d' "$i"
	sed -i '/\\(/ s//$/g' "$i"
	sed -i '/\\)/ s//$/g' "$i"
	# \textbackslash{} - \
	sed -i '/\\textbackslash{}/ s//\\/g' "$i"
	# \textgreater{} - >
	sed -i '/\\textgreater{}/ s//>/g' "$i"

	# Anführungszeichen
	# suchen und ersetzen: sed -i '/suchen/ s//ersetzen/g' "$i"
	# loeschen:  sed -i '/suchen/d' "$i"
	sed -i '/``/ s//<</g' "$i"
	sed -i "/''/ s//>>/g" "$i"
done
cd ..

echo "fertig"
