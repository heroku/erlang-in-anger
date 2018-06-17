LATEXMK      = latexmk
LATEXMKFLAG += -halt-on-error -pdf

SRC = text
DEPS = 000-copyright.tex 101-diving.tex 103-overload.tex 105-runtime-metrics.tex 107-memory-leaks.tex 109-tracing.tex 001-introduction.tex 102-building.tex 104-connecting.tex 106-crash-dumps.tex 108-cpu.tex 201-conclusion.tex

.PHONY: all clean

all: $(SRC).pdf

$(SRC).pdf: $(SRC).tex $(SRC).sty $(DEPS)
	$(LATEXMK) $(LATEXMKFLAG) $<

clean:
	$(LATEXMK) -C
