# Get the version info for later
PKGVERS := $(shell sed -n "s/Version: *\([^ ]*\)/\1/p" DESCRIPTION)

all: check clean

#docs:
#	R -q -e 'library("roxygen2"); roxygenise(".")'

build: #docs
	cd ..;\
	R CMD build pcurve

check: build
	cd ..;\
	R CMD check pcurve_$(PKGVERS).tar.gz

check-cran: build
	cd ..;\
	R CMD check --as-cran pcurve_$(PKGVERS).tar.gz

check-torture: build
	cd ..;\
	R CMD check --use-gct pcurve_$(PKGVERS).tar.gz

install: build
	cd ..;\
	R CMD INSTALL pcurve_$(PKGVERS).tar.gz

move: check
	cp ../pcurve.Rcheck/pcurve-Ex.Rout ./tests/Examples/pcurve-Ex.Rout.save

clean:
	cd ..;\
	rm -r pcurve.Rcheck/
