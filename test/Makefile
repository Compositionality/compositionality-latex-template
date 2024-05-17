SHELL = /usr/bin/env bash

index.xml:
	curl -o $@ 'https://export.arxiv.org/api/query?search_query=jr%3ACompositionality&start=0&max_results=100'

# TODO: we're skipping 1112.3076v4, 1812.02935v6 and 2105.03038v4 because of pstricks.
index.txt: index.xml
	cat $< \
		| grep '<id>' \
		| grep -Pv '(1112.3076v4|1812.02935v6|2105.03038v4)' \
		| grep -Po '(?<=http://arxiv.org/abs/)[0-9v.]+' \
		> $@

tar/%.tar.gz:
	mkdir -p tar
	curl -o $@ "http://arxiv.org/src/$*"

tar: index.txt
	cat $< | while read -r id; do make tar/$$id.tar.gz; done

src/%: tar/%.tar.gz
	mkdir -p $@
	tar -xvzf $< -C $@
	grep -lr "{compositionalityarticle}" $@/*.tex \
	 |  while read -r path; do mv "$$path" "$${path%/*}/main.tex"; done
	sed -i "s%{compositionalityarticle}%{../../../compositionalityarticle}%" $@/main.tex
	cp -f ../logo.eps $@
	cp -f ../ORCIDiD_iconvector.pdf $@

src: index.txt tar
	cat $< | while read -r id; do make src/$$id; done

src/%/main.pdf:
	cd src/$* && latexmk -gg -pdf -halt-on-error -quiet -shell-escape main.tex

all: src
	for folder in src/*; do make $$folder/main.pdf; done

log:
	for logfile in src/*/*.log; do \
		echo -e "\\n\\n========\\n\\n" && \
		texfot \
			--ignore "This is pdfTeX," \
			--ignore "epstopdf" \
			--ignore "Missing character: " \
			--ignore "LaTeX( Font)? Warning: " \
			--ignore "pdfTeX warning" \
			--ignore "Package \w+ Warning: " \
			--ignore '(Under|Over)full \\hbox' \
		cat $$logfile; \
	done

clobber:
	rm -rf src

