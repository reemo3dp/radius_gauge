OPENSCAD ?= openscad

.PHONY: all clean

clean:
	rm -rf stls/

all: \
    $(patsubst %,stls/concave_R%.3mf,$(shell seq 1 30)) \
	$(patsubst %,stls/convex_R%.3mf,$(shell seq 1 30))

stls/concave_R%.3mf: concave.scad
	@mkdir ./stls/ 2>/dev/null || true
	# Run openscad and assert that stderr contains "Objects:\s+2"
	$(OPENSCAD) -o $@ --enable lazy-union -D 'RADIUS=$*' $< 2>&1 | tee /dev/stderr | grep -qP 'Objects:\s+2'

stls/convex_R%.3mf: convex.scad
	@mkdir ./stls/ 2>/dev/null || true
	# Run openscad and assert that stderr contains "Objects:\s+2"
	$(OPENSCAD) -o $@ --enable lazy-union -D 'RADIUS=$*' $< 2>&1 | tee /dev/stderr | grep -qP 'Objects:\s+2'
