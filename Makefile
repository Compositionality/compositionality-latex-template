SHELL = /usr/bin/bash
PKG = compositionalityarticle

$(PKG).tar.gz: $(PKG).cls logo.eps ORCIDiD_iconvector.pdf $(PKG)-doc.tex $(PKG)-doc.pdf README.md
	ctanify --pkgname $(PKG) --no-tds $^

$(PKG)-doc.pdf: $(PKG)-doc.tex
	latexmk -pdf $<

clean:
	latexmk -c $(PKG)-doc.tex
	
clobber:
	latexmk -C $(PKG)-doc.tex
	rm -f $(PKG).tar.gz
