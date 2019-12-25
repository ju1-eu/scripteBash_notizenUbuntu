#!/bin/bash -e
# letztes Update: 24-Dez-19
# Markdown --> Latex & HTML5 & Wordpress"

# variable
#work=~/tex/projekt
md="md"
tex_pandoc="tex-pandoc"
#html="html"
cms_lokal="cms-lokal"
cms_server="cms-server"
#---------------------------
echo "+++ Markdown --> Latex & HTML5 & Wordpress"
cd $md
for i in *.md; do
	filename=`basename "$i" .md`
	# Latex
	pandoc "$i" -o ../$tex_pandoc/$filename.tex
	# Wordpress
	pandoc "$i" --to=html5 -o ../$cms_lokal/$filename.html
	pandoc "$i" --to=html5 -o ../$cms_server/$filename.html
	# HTML5
	#pandoc -s "$i" --to=html5 -o ../$html/$filename.html
done
cd ..

echo "fertig"
