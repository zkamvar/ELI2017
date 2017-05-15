TARGETS := packet/BiographicalSketch.pdf \
	packet/ProjectSummary.pdf \
	packet/ProjectNarrative.pdf \
	packet/BibliographyReferencesCited.pdf \
	packet/Equipment.pdf \
	packet/FacilitiesOtherResources.pdf

all : $(TARGETS)

packet/%.pdf : sections/%.tex ELI.bib
	latexmk -xelatex -r .latexmkrc $< $@

packet/%.pdf : sections/%.md
	pandoc -t latex --latex-engine=xelatex -o $@ $<

packet/%.docx : sections/%.tex
	pandoc -t docx --reference-docx $*-template.docx --latex-engine=xelatex -o $@ $<

clean: 
	latexmk -c
	$(RM) -r $(shell biber --cache)

cleanall: clean
	$(RM) $(TARGETS)

.PHONY: all clean cleanall