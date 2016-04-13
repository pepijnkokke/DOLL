default: README.pdf

README.pdf: README.md README.preamble README.bib
	pandoc -N -H README.preamble --bibliography README.bib -f markdown -o README.pdf README.md
