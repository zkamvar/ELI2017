TARGETS := sections/BiographicalSketch.pdf \
	sections/ProjectSummary.pdf \
	sections/ProjectNarrative.pdf \
	sections/BibliographyReferencesCited.pdf \
	sections/Equipment.pdf \
	sections/FacilitiesOtherResources.pdf

all : $(TARGETS)

%.pdf : %.tex ELI.bib
	latexmk -xelatex -r .latexmkrc $< $@

%.pdf : %.md
	pandoc -t latex --latex-engine=xelatex -o $@ $<

%.docx : %.tex
	pandoc -t docx --reference-docx $*-template.docx --latex-engine=xelatex -o $@ $<

clean: 
	latexmk -c
	$(RM) -r $(shell biber --cache)

cleanall: clean
	$(RM) $(TARGETS)

.PHONY: all clean cleanall