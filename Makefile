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
	rm -f $(PKG).{aux,dep,glo,gls,hd,idx,ilg,ind,listing,log,out,brf}
	
clobber: clean
	rm -f $(PKG).{ins,pdf,sty,tar.gz}

all_test_papers/%:
	mkdir $@
	curl "http://arxiv.org/src/$*" | tar -xz -C $@
	grep -lr "{compositionalityarticle}" $@/*.tex \
	 |  while read -r path; do mv "$$path" "$${path%/*}/main.tex"; done
	sed -i "s%{compositionalityarticle}%{../../compositionalityarticle}%" $@/main.tex
	cp logo.eps $@/

all_test_papers:
	mkdir -p $@
	curl --silent 'https://export.arxiv.org/api/query?search_query=jr%3ACompositionality&start=0&max_results=50' \
		| grep '<id>' \
		| grep -Po '(?<=http://arxiv.org/abs/)[0-9v.]+' \
 	| while read -r link; do make $@/$$link; done

canceltests:
	rm -rf all_test_papers/

test:
	for folder in all_test_papers/*; do \
	cd $$folder && \
	pwd && \
	latexmk -gg -quiet -halt-on-error -shell-escape main.tex || cd ..; \
	done

log:
	for logfile in all_test_papers/*/*.log; do \
	echo -e "\\n\\nFILE : \e[0;31m$$logfile\e[0m" && \
	texfot --ignore "LaTeX Warning: Citation" \
	       --ignore "LaTeX Warning: Reference" \
								--ignore "This is pdfTeX," \
								--ignore "epstopdf" \
								--ignore "LaTeX Warning: " \
								--ignore "Package \w+ Warning: " \
								--ignore "Package natbib Warning: Citation" \
								--ignore "Package hyperref Warning:" \
	       --ignore "LaTeX Warning: You have requested document class" \
	       --ignore "LaTeX Warning: Unused global option\(s\)" \
	       --ignore 'Underfull \\hbox' \
	       --ignore 'Overfull \\hbox' \
	cat $$logfile; \
	done

all_test_papers/%/main.pdf:
	cd all_test_papers/$* &&	latexmk -gg -shell-escape main.tex