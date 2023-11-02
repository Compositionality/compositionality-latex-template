SHELL = /usr/bin/bash
PKG = compositionalityarticle

# VERSION = UNRELEASED
# DATE = $(shell date +"%Y/%m/%d")

# INTERPOLATIONS  = s@<DATE>@$(DATE)@g;
# INTERPOLATIONS += s/<VERSION>/$(VERSION)/g;

$(PKG).tar.gz: $(PKG).ins $(PKG).pdf README.md
	ctanify --notds $^

$(PKG).pdf: $(PKG).dtx
	pdflatex $(PKG).dtx
	pdflatex $(PKG).dtx
	makeindex -s gglo.ist -o $(PKG).gls $(PKG).glo
	makeindex -s gind.ist -o $(PKG).ind $(PKG).idx
	pdflatex $(PKG).dtx
	pdflatex $(PKG).dtx

$(PKG).cls: $(PKG).ins $(PKG).dtx
	tex $<

watch:
	ls $(PKG).dtx | entr -c make $(PKG).pdf

gawk:
	ls $(PKG).dtx | entr -c texfot pdflatex -interaction=nonstopmode $(PKG).dtx

dev:
	ls $(PKG).dtx $(PKG)-doc-new.tex | entr -c make dev2
	
dev2:
	make $(PKG).cls
	texfot pdflatex -interaction=nonstopmode $(PKG)-doc-new.tex


clean:
	rm -f $(PKG).{aux,dep,glo,gls,hd,idx,ilg,ind,listing,log,out}
	
clobber: clean
	rm -f $(PKG).{ins,pdf,sty,tar.gz}

# interpolate:
# 	sed -i "$(INTERPOLATIONS)" $(PKG).dtx