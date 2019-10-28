LFLAGS = -pdf
LC = latexmk

default: proj1

proj1: proj1.tex references.bib
	$(LC) $(LFLAGS) proj1.tex

clean:
	$(LC) $(LFLAGS) -c proj1.tex
