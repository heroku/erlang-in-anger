NAME := text
HTMLNAME := text-html

.PHONY: all
all: html epub

.PHONY: html
html:
	awk -f patch.awk $(NAME).tex > $(HTMLNAME).tex
	hevea -s -O $(HTMLNAME)
	hevea -s -O $(HTMLNAME)

.PHONY: epub
epub:
	ebook-convert $(HTMLNAME).html $(NAME).epub --cover graphics/cover.png
	ebook-meta $(NAME).epub --title="Stuff Goes Bad: Erlang in Anger" \
										  		--authors="Fred Hebert" \
											  	--tags=erlang

.PHONY: clean
clean:
	rm -f $(NAME).{haux,html,htoc,epub}
	rm -f $(HTMLNAME).{haux,html,htoc,epub}
