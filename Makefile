# Lab Manual and Set-up Instructions

default: 
	@echo "make -n ... to display commands with running"
	@echo "make -s ... to not display commands when running them"
	@echo "Choices: setup-h, setup-l, 122-h, 122-l, images, list (prints copy-paste select image creation), counterr, toperr, typeerr, allerr"
	@echo "make all will make all html, all latex, and images"
	@echo -e "Suggested process: \nmake 122-p\nmake labdpdf (fix with PDFsam as instructed)\nmake checksize (then if different, continue)\nmake fixsize\nREPEAT ONCE"

git: 
	git diff-index --stat master

view: 
	/c/Program\ Files/Mozilla\ Firefox/firefox.exe TMC-lab-setup.html fall-lab-manual.html > /dev/null &

mathbook-setup-latex.xsl: 
	git diff-index --name-only master | grep mathbook-setup-latex.xsl && git diff-index --stat master 

mathbook-setup-html.xsl: 
	git diff-index --name-only master | grep mathbook-setup-html.xsl && git diff-index --stat master

mathbook-lab-latex.xsl: 
	git diff-index --name-only master | grep mathbook-lab-latex.xsl && git diff-index --stat master 

mathbook-lab-html.xsl: 
	git diff-index --name-only master | grep mathbook-lab-html.xsl && git diff-index --stat master

Lab-setup-122.ptx:
	git diff-index --name-only master | grep Lab-setup-122.ptx && git diff-index --stat master

122-Lab-Manual.ptx:
	git diff-index --name-only master | grep 122-Lab-Manual.ptx && git diff-index --stat master


${MATHBOOK}/user/mathbook-setup-latex.xsl: mathbook-setup-latex.xsl
	cp mathbook-setup-latex.xsl ${MATHBOOK}/user/

${MATHBOOK}/user/mathbook-setup-html.xsl: mathbook-setup-html.xsl
	cp mathbook-setup-html.xsl ${MATHBOOK}/user/

${MATHBOOK}/user/mathbook-lab-latex.xsl: mathbook-lab-latex.xsl
	cp mathbook-lab-latex.xsl ${MATHBOOK}/user/

${MATHBOOK}/user/mathbook-lab-html.xsl: mathbook-lab-html.xsl
	cp mathbook-lab-html.xsl ${MATHBOOK}/user/

setup-h: ${MATHBOOK}/user/mathbook-setup-html.xsl Lab-setup-122.ptx 
	xsltproc ${MATHBOOK}/user/mathbook-setup-html.xsl Lab-setup-122.ptx

setup-l: ${MATHBOOK}/user/mathbook-setup-latex.xsl Lab-setup-122.ptx 
	xsltproc ${MATHBOOK}/user/mathbook-setup-latex.xsl Lab-setup-122.ptx

setup-p: setup-l
	pdflatex TMC-lab-setup.tex

setup: setup-h setup-p


122-h: ${MATHBOOK}/user/mathbook-lab-html.xsl 122-Lab-Manual.ptx
	xsltproc ${MATHBOOK}/user/mathbook-lab-html.xsl 122-Lab-Manual.ptx
	@echo ""

122-l: ${MATHBOOK}/user/mathbook-lab-latex.xsl 122-Lab-Manual.ptx
	xsltproc ${MATHBOOK}/user/mathbook-lab-latex.xsl 122-Lab-Manual.ptx
	sed -i.sedfix -f 122-Lab-Manual.sed fall-lab-manual.tex

122-p: 122-l
	pdflatex fall-lab-manual.tex && pdflatex fall-lab-manual.tex || pdflatex fall-lab-manual.tex

122: 122-h 122-l

html: setup-h 122-h

latex: setup-l 122-l

pdf: 122-p setup-p

checksize:
	@echo "Building list.one and list.two..."
	@echo "#!/bin/sh" > list.one
	@echo "#!/bin/sh" > list.two
	@grep "PDF version" 122-Lab-Manual.ptx | sed 's#.*\">\(.*\)\.pdf (\([0-9][0-9]*\) kB.*#echo "echo -e \\\"claim: \2\\\\tactual:\\\" \\\\`expr `stat --printf=%s \1.pdf` / 1000\\\\`\\\\\t\1" >> list.two#g' >> list.one 
	./list.one 
	./list.two

fixsize:
	@echo "Building step.one and step.two..."
	@echo "#!/bin/sh" > step.one
	@echo "#!/bin/sh" > step.two
	@grep "PDF version" 122-Lab-Manual.ptx | sed 's#.*\">\(.*\)\.pdf (\([0-9][0-9]*\) kB.*#echo "echo \\"s^\1.pdf (\2 kB)^\1.pdf (\\\\`expr `stat --printf=%s \1.pdf` / 1000\\\\` kB)^g\\"" >> step.two#g' >> step.one 
	./step.one 
	./step.two > step.sed
	sed -i.size -f step.sed 122-Lab-Manual.ptx

buildpdfs: fall-lab-manual.tex
	@echo "Creating scripttolistbyname... (print at end)"
	@echo "#!/bin/sh" > scripttolistbyname
	@grep "chapter" fall-lab-manual.toc | \
		sed -n 'N;l;D' | \
		sed ':x ; $$!N ; s/\\\\\n// ; tx ; P ; D' | \
		grep -v "chapter\*" | \
		sed 's/\(.*\)\$$/\1/g' | \
		sed 's/.*{.*}{.*{.*}.\{3\}\(.*\)}{\([0-9][0-9]*\)}{\(.*\)}.*{.*}{.*{.*}.*}{\([0-9][0-9]*\)}{.*}/grep \"\1\\}\\\\\\\\\\\\\\\\label\" fall-lab-manual.tex \| sed \x22s#.\*label{\\\\(.\*\\\\)}#\3: `expr \2 + 12`..`expr \4 + 11`\\\\t\\\\1#g\x22 \| sed \x27s#c-##g\x27/g' \
		>> scripttolistbyname
	@echo "Creating buildscript..."
	@echo "#!/bin/sh" > buildscript
	@grep "chapter" fall-lab-manual.toc | \
		sed -n 'N;l;D' | \
		sed ':x ; $$!N ; s/\\\\\n// ; tx ; P ; D' | \
		grep -v "chapter\*" | \
		sed 's/\(.*\)\$$/\1/g' | \
		sed 's/.*{.*}{.*{.*}.\{3\}\(.*\)}{\([0-9][0-9]*\)}{\(.*\)}.*{.*}{.*{.*}.*}{\([0-9][0-9]*\)}{.*}/grep \"\1\\}\\\\\\\\\\\\\\\\label\" fall-lab-manual.tex \| sed \x22s#c-##g\x22 \| sed \x22s#.\*label{\\\\(.\*\\\\)}#pdfseparate -f `expr \2 + 12` -l `expr \4 + 11` fall-lab-manual.pdf \\\\1.\%d.pdf ; rm \\\\1_big.pdf \\\\1.pdf ; pdfunite \\\\1.*.pdf \\\\1_big.pdf ; rm \\\\1.*.pdf ; ps2pdf \\\\1_big.pdf \\\\1.pdf#g\x22/g' \
		>> buildscript
	@echo "#!/bin/sh" > buildpdfs
	@echo "Using buildscript to create buildpdfs..."
	./buildscript >> buildpdfs
	@echo "Running buildpdfs to create the lab pdfs."
	./buildpdfs 2> /dev/null
	./scripttolistbyname
	@echo "You need to use PDFsam to fix the labs with pictures: measurement and StDev."
	@echo -e "I am going to run PDFsam, you should do this:\nextract pages listed\nmv PDFsam_fall-lab-manual.pdf measurement.pdf\nextract pages for StDev\nmv PDFsam_fall-lab-manual.pdf StDev.pdf\nmake checksize\nmake fixsize\n./scripttolistbyname"
	@/c/Program\ Files\ \(x86\)/PDFsam\ Basic/bin/pdfsam.sh -e ./fall-lab-manual.pdf &

labpdf: buildpdfs

images: 122-Lab-Manual.ptx Lab-setup-122.ptx
	${MATHBOOK}/script/mbx -v -c latex-image -f svg -d images ${AIY}/122-Lab-Manual.ptx
#	${MATHBOOK}/script/mbx -v -c latex-image -r [specific image reference] -f svg -d images ${AIY}/122-Lab-Manual.ptx
	${MATHBOOK}/script/mbx -v -c latex-image -f svg -d images ${AIY}/Lab-setup-122.ptx


# To list the images in the ptx and print a line that will check to see if that image exists and (if not) try to create the image...

list: 122-Lab-Manual.ptx Lab-setup-122.ptx
	cat Lab-setup-122.ptx | \
		sed 's/^ *<image/<image/g' | \
		grep '<image' | grep -v "images" | \
		sed 's/ width=.*>/>/g' | \
		sed 's+^.*ptx:id=\"\(.*\)\">+ls images/\1.svg || C:/Users/tensen/Desktop/Book/mathbook/script/mbx \-v \-c latex-image \-r \1 \-f svg \-d images ${AIY}/Lab-setup-122.ptx+g'
	@echo "*************************"
	cat 122-Lab-Manual.ptx | \
		sed 's/^ *<image/<image/g' | \
		grep '<image' | grep -v "images" | \
		sed 's/ width=.*>/>/g' | \
		sed 's+^.*ptx:id=\"\(.*\)\">+ls images/\1.svg || C:/Users/tensen/Desktop/Book/mathbook/script/mbx \-v \-c latex-image \-r \1 \-f svg \-d images ${AIY}/122-Lab-Manual.ptx+g'

counterr: ${MATHBOOK}/../jing-trang/build/jing.jar ${MATHBOOK}/schema/pretext.rng 122-Lab-Manual.ptx  Lab-setup-122.ptx
	@echo `java -jar ${MATHBOOK}/../jing-trang/build/jing.jar ${MATHBOOK}/schema/pretext.rng Lab-setup-122.ptx | wc -l`" errors"
	@echo `java -jar ${MATHBOOK}/../jing-trang/build/jing.jar ${MATHBOOK}/schema/pretext.rng 122-Lab-Manual.ptx | wc -l`" errors"

toperr: ${MATHBOOK}/../jing-trang/build/jing.jar ${MATHBOOK}/schema/pretext.rng 122-Lab-Manual.ptx  Lab-setup-122.ptx
	java -jar ${MATHBOOK}/../jing-trang/build/jing.jar ${MATHBOOK}/schema/pretext.rng Lab-setup-122.ptx | head -5
	@echo "*************************"
	java -jar ${MATHBOOK}/../jing-trang/build/jing.jar ${MATHBOOK}/schema/pretext.rng 122-Lab-Manual.ptx | head -5

typeerr: ${MATHBOOK}/../jing-trang/build/jing.jar ${MATHBOOK}/schema/pretext.rng 122-Lab-Manual.ptx  Lab-setup-122.ptx
	java -jar ${MATHBOOK}/../jing-trang/build/jing.jar ${MATHBOOK}/schema/pretext.rng Lab-setup-122.ptx | \
		sed 's/.*:\([0-9][0-9]*\):\([0-9][0-9]*\): error: element "\([a-zA-Z][a-zA-Z]*\)".*/\3 line \1:\2/g' | \
		sort -k1
	@echo "*************************"
	java -jar ${MATHBOOK}/../jing-trang/build/jing.jar ${MATHBOOK}/schema/pretext.rng 122-Lab-Manual.ptx | \
		sed 's/.*:\([0-9][0-9]*\):\([0-9][0-9]*\): error: element "\([a-zA-Z][a-zA-Z]*\)".*/\3 line \1:\2/g' | \
		sort -k1

# To find the errors on "todo"  (must change in two places)                                                vvvv                                                 vvvv
# 	java -jar ${MATHBOOK}/../jing-trang/build/jing.jar ${MATHBOOK}/schema/pretext.rng 122-Lab-Manual.ptx | grep ": element \"todo" | sed 's/.*:\([0-9][0-9]*\):\([0-9][0-9]*\):.*/todo line \1:\2/g'
#                                                                                                          ^^^^                                                 ^^^^

allerr: ${MATHBOOK}/../jing-trang/build/jing.jar ${MATHBOOK}/schema/pretext.rng 122-Lab-Manual.ptx  Lab-setup-122.ptx
	java -jar ${MATHBOOK}/../jing-trang/build/jing.jar ${MATHBOOK}/schema/pretext.rng Lab-setup-122.ptx | \
		sort -k4  
	@echo "*************************"
	java -jar ${MATHBOOK}/../jing-trang/build/jing.jar ${MATHBOOK}/schema/pretext.rng 122-Lab-Manual.ptx | \
		sort -k4  

all: setup-h 122-h setup-l 122-l images
