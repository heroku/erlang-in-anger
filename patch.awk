### Convert the LaTeX file to something HaVeA can understand to then
### convert it to HTML so that Calibre can convert things to EPUB or
### MOBI

## Drop comments
/^%/ { next }

## no custom verbatim environments
/^\\DefineVerbatimEnvironment/ { next }

## override textual Verb commands
/\\newcommand{.*}\[1\]{\\Verb`#1`}/ {
    end = match($0, "}");
    cmd = substr($0,14,end-14)
    # show the line as-is, then the renewed copy with style
    print $0;
    print "\\renewcommand{\\" cmd "}[2][]{{\\@styleattr{" cmd "}{\\@addstyle{#1}{style=\"font-family:courier,monospace\"}}#2}}";
    next;
}

## remove footnote color
/\\renewcommand\\thefootnote/ {
    print "\\renewcommand\\thefootnote{{\\arabic{footnote}}}";
    next;
}

## Drop cover page, handled elsewhere
/\\includepdf(.*)graphics\/cover.pdf/ { next }

## Replace images
#<   \includegraphics{allocation-1-normal.pdf}%
#>   \imgsrc{graphics/allocation-1-normal.pdf}%
/\\includegraphics{.*}/ {
    start = index($0, "{")+1;
    end = index($0, "}")-4; # skip the ext
    file = substr($0, start, end-start);
    print "\\imgsrc{graphics/" file ".png" substr($0, end+4);
    next;
}
## Replace images with options
#<   \includegraphics[max height=7cm]{tracing-venn.pdf}%
#>   \imgsrc[max height=7cm]{graphics/tracing-venn.pdf}%
/\\includegraphics\[.*\]{.*}/ {
    start_opts = index($0, "[")+1;
    end_opts = index($0, "]");
    opts = substr($0, start_opts, end_opts-start_opts);
    start_file = index($0, "{")+1;
    end_file = index($0, "}")-4; # skip the ext
    file = substr($0, start_file, end_file-start_file);
    print "\\imgsrc[" opts "]{graphics/" file ".png" substr($0, end_file+4);
    next;
}

## Replace code snippets
/^\\includecode\[erlang\]{.*}/ {
    file = substr($0, 22, length($0)-22);
    print "\\VerbatimInput{erlang/" file "}";
    next;
}

## Replace silent chapters/sections with ToC entry with regular ones
## this renumbers the chapters and sucks
#/^\\chapter\*{/ {
#    print "\\chapter{" substr($0,11);
#    next;
#}
#/^\\section\*{/ {
#    print "\\section{" substr($0,11);
#    next;
#}
#/^\\subsection\*{/ {
#    print "\\subsection{" substr($0,14);
#    next;
#}

## Verbatim replacements
/\\begin{Verbatim.*}/ { print "\\begin{Verbatim}"; next; }
/\\end{Verbatim.*}/   { print "\\end{Verbatim}"; next; }

## Replace enumerates
/\\begin{enumerate.*}/ { print "\\begin{enumerate}"; next; }
/\\end{enumerate.*}/   { print "\\end{enumerate}"; next; }

## Replace itemize
/\\begin{itemize.*}/ { print "\\begin{itemize}"; next; }
/\\end{itemize.*}/   { print "\\end{itemize}"; next; }

## Leave as is
{ print $0 }
