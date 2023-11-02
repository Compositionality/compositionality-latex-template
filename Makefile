SHELL = /usr/bin/bash
PKG = compositionalityarticle

$(PKG).tar.gz: $(PKG).cls logo.eps $(PKG).tex $(PKG).pdf README.md
	ctanify --pkgname $(PKG) --no-tds $^

$(PKG).pdf: $(PKG).tex
	latexmk -pdf $<

clean:
	latexmk -c $(PKG).tex
	
clobber:
	latexmk -C $(PKG).tex
	rm -f $(PKG).tar.gz
