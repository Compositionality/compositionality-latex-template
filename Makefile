build/doc/compositionalityarticle.pdf build/unpacked/compositionalityarticle.cls: compositionalityarticle.dtx compositionalityarticle.ins build.lua
	l3build doc

mwe.pdf: mwe.tex build/unpacked/compositionalityarticle.cls
	latexmk -pdf mwe.tex