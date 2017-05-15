TARGETS := znk-concept-paper.pdf brain-dumps.pdf bio-sketch.pdf
all : $(TARGETS)

%.pdf : %.tex
	latexmk -xelatex -r .latexmkrc $(<F)

%.pdf : %.md
	pandoc -t latex --latex-engine=xelatex -o $@ $^

%.docx : %.tex
	pandoc -t docx --reference-docx $*-template.docx --latex-engine=xelatex -o $@ $^

clean: 
	latexmk -c
	$(RM) -r $(shell biber --cache)

cleanall: clean
	$(RM) $(TARGETS)

.PHONY: all clean cleanall