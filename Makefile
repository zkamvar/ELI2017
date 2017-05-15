TARGETS := BiographicalSketch.pdf \
	ProjectSummary.pdf \
	ProjectNarrative.pdf \
	BibliographyReferencesCited.pdf \
	Equipment.pdf \
	FacilitiesOtherResources.pdf

all : packet/ProjectNarrative.pdf # $(TARGETS)

packet/%.pdf : %.tex config.tex ELI.bib
	latexmk -xelatex -r .latexmkrc $<

%.pdf : %.md
	pandoc -t latex --latex-engine=xelatex -o $@ $<

%.docx : %.tex
	pandoc -t docx --reference-docx $*-template.docx --latex-engine=xelatex -o $@ $<

clean : $(TARGETS)
	latexmk -c -r .latexmkrc
	$(RM) -r $(shell biber --cache)

cleanall :
	latexmk -C -r .latexmkrc

.PHONY: all clean cleanall