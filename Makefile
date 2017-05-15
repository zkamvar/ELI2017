TARGETS := packet/BiographicalSketch.pdf \
	packet/ProjectSummary.pdf \
	packet/ProjectNarrative.pdf \
	packet/BibliographyReferencesCited.pdf \
	packet/Equipment.pdf \
	packet/FacilitiesOtherResources.pdf

all : $(TARGETS)

packet/%.pdf : %.tex config.tex ELI.bib
	latexmk -xelatex -quiet -r .latexmkrc $<

packet/BibliographyReferencesCited.pdf : BibliographyReferencesCited.tex packet/ProjectNarrative.pdf
	biber --output_format=bibtex --output_resolve packet/ProjectNarrative.bcf
	latexmk -xelatex -quiet -r .latexmkrc $<

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