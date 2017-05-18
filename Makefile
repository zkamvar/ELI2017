TARGETS := packet/LogicModel.pdf \
	packet/BiographicalSketch.pdf \
	packet/ProjectSummary.pdf \
	packet/ProjectNarrative.pdf \
	packet/BibliographyReferencesCited.pdf \
	packet/FacilitiesOtherResources.pdf \
	packet/Equipment.pdf \
	packet/BudgetJustification.pdf \
	packet/ConflictOfInterest.pdf \
	packet/ManagementPlan.pdf \
	packet/DataManagementPlan.pdf  
	

all : $(TARGETS)

packet/%.pdf : %.tex config.tex ELI.bib
	latexmk -xelatex -quiet -r .latexmkrc $<

# The bibliography must be separate. It depends on the rendering of the
# ProjectNarrative to get it in the correct order
packet/BibliographyReferencesCited.pdf : BibliographyReferencesCited.tex \
										 packet/ProjectNarrative.pdf
	# https://tex.stackexchange.com/a/164328/77699
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

# This will only work on OSX
.PHONY: open

open : $(TARGETS)
	open $^