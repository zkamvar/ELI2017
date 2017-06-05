TARGETS := packet/LogicModel.pdf \
	packet/BiographicalSketch.pdf \
	packet/ProjectSummary.pdf \
	packet/timeline.pdf \
	packet/ProjectNarrative.pdf \
	packet/BibliographyReferencesCited.pdf \
	packet/FacilitiesOtherResources.pdf \
	packet/Equipment.pdf \
	packet/BudgetJustification.pdf \
	packet/ConflictOfInterest.pdf \
	packet/ManagementPlan.pdf \
	packet/DataManagementPlan.pdf  
WARGETS := $(patsubst %.pdf, %.docx, $(TARGETS))

all : $(TARGETS)

.PHONY : words
words : $(WARGETS)

.PHONY : dots
dots : figure/rr.pdf

packet/%.pdf : %.tex config.tex ELI.bib
	-latexmk -xelatex -quiet -r .latexmkrc $<

figure/%.pdf : figure/%.dot
	dot -Tpdf -o $@ $<

packet/ProjectNarrative.pdf : ProjectNarrative.tex packet/timeline.pdf
	-latexmk -xelatex -quiet -r .latexmkrc $<

# The bibliography must be separate. It depends on the rendering of the
# ProjectNarrative to get it in the correct order
packet/BibliographyReferencesCited.pdf : BibliographyReferencesCited.tex \
                                         packet/ProjectNarrative.pdf
	# https://tex.stackexchange.com/a/164328/77699
	biber --output_format=bibtex --output_resolve packet/ProjectNarrative.bcf
	latexmk -xelatex -quiet -r .latexmkrc $<

packet/BibliographyReferencesCited.docx : BibliographyReferencesCited.tex \
                                          packet/ProjectNarrative.pdf
	# https://tex.stackexchange.com/a/164328/77699
	biber --output_format=bibtex --output_resolve packet/ProjectNarrative.bcf
	pandoc -t docx --latex-engine=xelatex --latex-engine-opt="-r .latexmkrc" -o $@ $<

%.pdf : %.md
	pandoc -t latex --latex-engine=xelatex --latex-engine-opt="-r .latexmkrc" -o $@ $<

packet/%.docx : %.tex
	pandoc -t docx --latex-engine=xelatex --latex-engine-opt="-r .latexmkrc" -o $@ $<

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

.PHONY: wopen

wopen : $(WARGETS)
	open $^