NAME := text
HTMLNAME := text-html

.PHONY: all
all: html mobi epub

.PHONY: html
html:
	awk -f patch.awk $(NAME).tex > $(HTMLNAME).tex
	hevea -s -O $(HTMLNAME)
	hevea -s -O $(HTMLNAME)

.PHONY: mobi
mobi:
	ebook-convert $(HTMLNAME).html $(NAME).mobi --cover graphics/cover.png
	ebook-meta $(NAME).mobi --title="Stuff Goes Bad: Erlang in Anger" \
										  		--authors="Fred Hebert" \
											  	--tags=erlang


.PHONY: epub
epub:
	ebook-convert $(HTMLNAME).html $(NAME).epub --cover graphics/cover.png
	ebook-meta $(NAME).epub --title="Stuff Goes Bad: Erlang in Anger" \
										  		--authors="Fred Hebert" \
											  	--tags=erlang

.PHONY: clean
clean:
	rm -f $(NAME).{haux,html,htoc,epub,mobi}
	rm -f $(HTMLNAME).{haux,html,htoc,epub,mobi}
