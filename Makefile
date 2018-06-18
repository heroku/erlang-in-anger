LATEXMK      = latexmk

LATEXMKFLAG += -latex=pdflatex -halt-on-error -pdf
SRC = text
DEPS = 000-copyright.tex 101-diving.tex 103-overload.tex 105-runtime-metrics.tex 107-memory-leaks.tex 109-tracing.tex 001-introduction.tex 102-building.tex 104-connecting.tex 106-crash-dumps.tex 108-cpu.tex 201-conclusion.tex

LATEXMKFLAG_JA += -latex=lualatex -halt-on-error -pdf
SRC_JA = text-ja
DEPS_JA = 000-copyright-ja.tex 001-introduction.tex

.PHONY: english japanese clean

english: $(SRC).pdf

japanese: $(SRC_JA).pdf

$(SRC).pdf: $(SRC).tex $(SRC).sty $(DEPS)
	$(LATEXMK) $(LATEXMKFLAG) $<

$(SRC_JA).pdf: $(SRC_JA).tex $(SRC).sty $(DEPS_JA)
	$(LATEXMK) $(LATEXMKFLAG_JA) $<

clean:
	$(LATEXMK) -C
