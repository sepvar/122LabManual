# sed file, meant to be run with:
# sed -f convert-tex2ptx.sed toconvert.tex | sed 'N;s|<li><p>\n</p></li>||g' > out.tex
# sed -f convert-tex2ptx.sed 122-Lab-Manual-postsed.tex | sed 'N;s|<li><p>\n</p></li>||g' > 122-Lab-Manual-converted.tex.`ls 122-Lab-Manual-converted.tex* | wc -l`
# sed -f convert-tex2ptx.sed 122-Lab-Manual-postsed.tex | sed '$!N;s|\n[ ]*</p></li>| </p></li>|;P;D' | sed 's|<li><p>[ ]*</p></li>||g' > 122-Lab-Manual-converted.tex.`ls 122-Lab-Manual-converted.tex* | wc -l`
s| \-\-\- | <mdash \/> |g
s| \-\- | <mdash \/> |g
s|^%\(.*\)|<!-- \1 -->|g
s|\\latex{``}\\html{"}|<q>|g
s|``|<q>|g
s|''|</q>|g
s|"|</q>|g
s|\\section.*{\(.*\)}|</chapter>\n<chapter xml:id="TEMP-NAME"><title>\1</title>|g
s/{s:/{c:/g
s/\([sS]\)ubsection/\1ection/g
s|\\\([sub]*section\)[^{]*{\(.*\)}\\label{\(.*\)}\(.*\)|</\1>\n<\1 xml:id="\3"><title>\2</title>\4|g
s|\\\([sub]*section\)[^{]*{\(.*\)}\(.*\)|</\1>\n<\1><title>\2</title>\3|g
s/{ss:/{s:/g
s/{sss:/{ss:/g
s|\(.*\)(\$\(.*\)\$)\(.*\)|\1<m>(\2)</m>\3|g
s|\(.*\)(\$\(.*\)\$)\(.*\)|\1<m>(\2)</m>\3|g
s|\(.*\)(\$\(.*\)\$)\(.*\)|\1<m>(\2)</m>\3|g
s|\(.*\)(\$\(.*\)\$)\(.*\)|\1<m>(\2)</m>\3|g
s|\(.*\)\$\(.*\)\$\(.*\)|\1<m>\2</m>\3|g
s|\(.*\)\$\(.*\)\$\(.*\)|\1<m>\2</m>\3|g
s|\(.*\)\$\(.*\)\$\(.*\)|\1<m>\2</m>\3|g
s|\(.*\)\$\(.*\)\$\(.*\)|\1<m>\2</m>\3|g
s|\(.*\)\$\(.*\)\$\(.*\)|\1<m>\2</m>\3|g
s|\(.*\)\$\(.*\)\$\(.*\)|\1<m>\2</m>\3|g
s|\(.*\)\$\(.*\)\$\(.*\)|\1<m>\2</m>\3|g
s|\(.*\)\$\(.*\)\$\(.*\)|\1<m>\2</m>\3|g
s|\(.*\)\$\(.*\)\$\(.*\)|\1<m>\2</m>\3|g
s|\(\\put.*\)<m>\(.*\)</m>\(.*\)|\1$\2$\3|g
s|\\label{\([a-zA-Z0-9][a-zA-Z0-9]*\):\([a-zA-Z0-9\-][a-zA-Z0-9\-]*\)}|\\label{\1-\2\}|g
s|\\ref{\([a-zA-Z0-9][a-zA-Z0-9]*\):\([a-zA-Z0-9\-][a-zA-Z0-9\-]*\)}|\\ref{\1-\2\}|g
s|\\label{\([a-zA-Z0-9][a-zA-Z0-9]*\):\([a-zA-Z0-9\.][a-zA-Z0-9\.]*\)}|\\label{\1-\2\}|g
s|\\ref{\([a-zA-Z0-9][a-zA-Z0-9]*\):\([a-zA-Z0-9\.][a-zA-Z0-9\.]*\)}|\\ref{\1-\2\}|g
s|\\label{\([a-zA-Z0-9][a-zA-Z0-9]*\):\([a-zA-Z0-9\_][a-zA-Z0-9\_]*\)}|\\label{\1-\2\}|g
s|\\ref{\([a-zA-Z0-9][a-zA-Z0-9]*\):\([a-zA-Z0-9\_][a-zA-_0-9\_]*\)}|\\ref{\1-\2\}|g
s|\\label{\([a-zA-Z0-9\-][a-zA-Z0-9\-]*\)\_\([a-zA-Z0-9\_][a-zA-Z0-9\_]*\)}|\\label{\1-\2\}|g
s|\\label{\([a-zA-Z0-9\-][a-zA-Z0-9\-]*\)\_\([a-zA-Z0-9\_][a-zA-Z0-9\_]*\)}|\\label{\1-\2\}|g
s|\\ref{\([a-zA-Z0-9\-][a-zA-Z0-9\-]*\)\_\([a-zA-Z0-9\_][a-zA-Z0-9\_]*\)}|\\ref{\1-\2\}|g
s|\\ref{\([a-zA-Z0-9\-][a-zA-Z0-9\-]*\)\_\([a-zA-Z0-9\_][a-zA-Z0-9\_]*\)}|\\ref{\1-\2\}|g
s|\\label{\([a-zA-Z0-9\-][a-zA-Z0-9\-]*\)\.\([a-zA-Z0-9\.][a-zA-Z0-9\.]*\)}|\\label{\1-\2\}|g
s|\\label{\([a-zA-Z0-9\-][a-zA-Z0-9\-]*\)\.\([a-zA-Z0-9\.][a-zA-Z0-9\.]*\)}|\\label{\1-\2\}|g
s|\\label{\([a-zA-Z0-9\-][a-zA-Z0-9\-]*\)\.\([a-zA-Z0-9\.][a-zA-Z0-9\.]*\)}|\\label{\1-\2\}|g
s|\\ref{\([a-zA-Z0-9\-][a-zA-Z0-9\-]*\)\.\([a-zA-Z0-9\.][a-zA-Z0-9\.]*\)}|\\ref{\1-\2\}|g
s|\\ref{\([a-zA-Z0-9\-][a-zA-Z0-9\-]*\)\.\([a-zA-Z0-9\.][a-zA-Z0-9\.]*\)}|\\ref{\1-\2\}|g
s|\\ref{\([a-zA-Z0-9\-][a-zA-Z0-9\-]*\)\.\([a-zA-Z0-9\.][a-zA-Z0-9\.]*\)}|\\ref{\1-\2\}|g
s|\\begin{equation}[ ]*\\label{\(.*\)}|<men xml:id="\1">|g
s|\\begin{equation}|<men>|g
s|\\end{equation}|</men>|g
s|\\\[|<me>|g
s|\\\]|</me>|g
s|\\begin{eqnarray\*}|<md>|g
s|\\begin{eqnarray}|<mdn>|g
s|\(.*\) & = & \(.*\)\\label{\([a-zA-Z0-9\-]*\)}\(.*\)|<mrow xml:id="\3"> \1 \\amp = \2 \4</mrow>|g
s|\(.*\) & = & \(.*\)|<mrow> \1 \\amp = \2 </mrow>|g
s|\\\\[ ]*</mrow>|</mrow>|g
s|\\\\&&|</mrow>\n<mrow> \\amp|g
s|& & \(.*\) \\\\|<mrow>\1</mrow>|g
s|\\end{eqnarray}|</mdn>|g
s|\\end{eqnarray\*}|</md>|g
# s|\\\%|<percent />|g
s|\\\%-\([eud]\)|<percent />-\1|g
s|\\\%\.|<percent />.|g
s|\\\% of|<percent /> of|g
# s|\\\#|<hash />|g
s|\\ldots|<ellipsis />|g
s|\\mbox{|\\text{|g
s|\\protect{\(\\ref{.*}\)}|\1|g
s|Eq\.~(\\ref{\([a-zA-Z0-9\-]*\)})|<xref ref="\1" text="type-global" />|g
s|Lab~\\ref{\([a-zA-Z0-9\-]*\)}|<xref ref="\1" text="type-global" />|g
s|Figure~\\ref{\([a-zA-Z0-9\-]*\)}|<xref ref="\1" text="type-global" />|g
s|Fig\.~\\ref{\([a-zA-Z0-9\-]*\)}|<xref ref="\1" text="type-global" />|g
s|Section~\\ref{\([a-zA-Z0-9\-]*\)}|<xref ref="\1" text="type-global" />|g
s|Sec\.~\\ref{\([a-zA-Z0-9\-]*\)}|<xref ref="\1" text="type-global" />|g
s|part~\\ref{\([a-zA-Z0-9\-]*\)}|<xref ref="\1" text="type-global" />|g
s|~\\ref{q-\([a-zA-Z0-9\-]*\)}| <xref ref="q-\1" text="global">Question</xref>|g
s|\\ref{q-\([a-zA-Z0-9\-]*\)}|<xref ref="q-\1" text="global">Question</xref>|g
s|~\\ref{\([a-zA-Z0-9\-]*\)}| <xref ref="\1" text="type-global" />|g
s|\\ref{\([a-zA-Z0-9\-]*\)}|<xref ref="\1" text="type-global" />|g
s|\\begin{figure}\[[tbhp]*\]|<figure xml:id="TEMP-FIG-LABEL">\n<caption>CAPTION GOES HERE</caption>\n<image xml:id="i-FIGURE-NAME">\n<latex-image>|g
s|\\includegraphics\[\(.*\)\]{\(.*\)}|<!-- REMOVE latex-image AND REPLACE image WITH (Note: width should be a percentage) -->\n<image xml:id="i-FIGURE-NAME" width="\1" source="images/\2">|g
s|\\caption\[\(.*\)\]{\(.*\)}|<!-- SHORT VERSION -->\n<!-- <caption>\1</caption> -->\n<!-- LONG VERSION -->\n<caption>\2</caption>|g
s|\\caption{\(.*\)}|<caption>\1</caption>|g
s|\\end{figure}|</latex-image>\n</image>\n</figure>|g
s|\\begin{question}|<exercise>\n<statement><p>\n<ol>\n\t<li><p>|g
s|\\begin{description}|<dl>\n\t<li><p>|g
s|\\begin{lablist}|<ul>\n\t<li><p>|g
s|\\begin{itemize}|<ul>\n\t<li><p>|g
s|\\begin{enumerate}|<ol>\n\t<li><p>|g
s|\\itemsep [0-9inptcm\-]*||g
s|\\item\[\]|</p><p>|g
s|\\item[ ]*\[\(.*\)\]|</p></li>\n\t<li><title>\1</title><p>|g
s|\\item[ ]*\\label{\([a-zA-Z0-9\-]*\)}|</p></li>\n\t<li xml:id="\1"><p>|g
s|\\item|</p></li>\n\t<li><p>|g
s|\\end{question}|</p></li>\n</ol>\n</p></statement>\n</exercise>|g
s|\\end{description}|</p></li>\n</dl>|g
s|\\end{enumerate}|</p></li>\n</ol>|g
s|\\end{itemize}|</p></li>\n</ul>|g
s|\\end{lablist}|</p></li>\n</ul>|g
s|\\revised{\(.*\)}|<conclusion><p>Last revised: \1 </p></conclusion>|g
s|\\revision{\(.*\)}{\(.*\)}|<!-- <p>Previous revisions: (\1) \2 </p>  -->|g
s|\(.*\)\\footnote{\(.*\)}\(.*\)|\1<fn>\2</fn>\3|g
s|\(.*\){\\sl \(.*\)}[\\/]*\(.*\)|\1<em>\2</em>\3|g
s|\(.*\){\\sl \(.*\)}[\\/]*\(.*\)|\1<em>\2</em>\3|g
s|\(.*\){\\sl \(.*\)}[\\/]*\(.*\)|\1<em>\2</em>\3|g
s|\(.*\){\\it \(.*\)}[\\/]*\(.*\)|\1<em>\2</em>\3|g
s|\(.*\){\\it \(.*\)}[\\/]*\(.*\)|\1<em>\2</em>\3|g
s|\(.*\){\\it \(.*\)}[\\/]*\(.*\)|\1<em>\2</em>\3|g
s|\(.*\){\\bf \(.*\)}[\\/]*\(.*\)|\1<alert>\2</alert>\3|g
s|\(.*\){\\bf \(.*\)}[\\/]*\(.*\)|\1<alert>\2</alert>\3|g
s|\(.*\){\\bf \(.*\)}[\\/]*\(.*\)|\1<alert>\2</alert>\3|g
s|{\\rm \(.*\)}|\\text{\1}|g
s|\\underline{\\sc \(.*\)}|<term>\1</term>|g
s|\(.*\){\\sc \(.*\)}[\\/]*\(.*\)|\1<term>\2</term>\3|g
s|\(.*\){\\sc \(.*\)}[\\/]*\(.*\)|\1<term>\2</term>\3|g
s|\\underline{\(.*\)}|<em>\1</em>|g
s|\\label{\(.*\)}|<!-- xml:id="\1" INSERT THIS ABOVE -->|g
