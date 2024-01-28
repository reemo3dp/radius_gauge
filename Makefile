OPENSCAD ?= openscad

.PHONY: all clean

clean:
	rm -rf stls/

all: \
    $(patsubst %,stls/concave_classic_R%.3mf,$(shell seq 1 30)) \
	$(patsubst %,stls/convex_classic_R%.3mf,$(shell seq 1 30)) \
    $(patsubst %,stls/concave_remix_R%.3mf,$(shell seq 1 30)) \
	$(patsubst %,stls/convex_remix_R%.3mf,$(shell seq 1 30)) 

stls/concave_classic_R%.3mf: radius_gauge.scad
	@mkdir ./stls/ 2>/dev/null || true
	$(OPENSCAD) -o $@ --enable lazy-union \
		-D 'FLIP=true' \
		-D 'TYPE="concave"' \
		-D 'TAB=false' \
		-D 'BASE_WIDTH=35' \
		-D 'CHAMFER_WIDTH=1' \
		-D 'RADIUS=$*' \
		$< 2>&1 | tee /dev/stderr | grep -qP 'Objects:\s+2'

stls/convex_classic_R%.3mf: radius_gauge.scad
	@mkdir ./stls/ 2>/dev/null || true
	$(OPENSCAD) -o $@ --enable lazy-union \
		-D 'FLIP=true' \
		-D 'TYPE="convex"' \
		-D 'TAB=false' \
		-D 'BASE_WIDTH=35' \
		-D 'CHAMFER_WIDTH=1' \
		-D 'RADIUS=$*' \
		$< 2>&1 | tee /dev/stderr | grep -qP 'Objects:\s+2'

stls/concave_remix_R%.3mf: radius_gauge.scad
	@mkdir ./stls/ 2>/dev/null || true
	$(OPENSCAD) -o $@ --enable lazy-union \
		-D 'FLIP=true' \
		-D 'TYPE="convex"' \
		-D 'TAB=true' \
		-D 'BASE_WIDTH=34.9' \
		-D 'CHAMFER_WIDTH=2' \
		-D 'RADIUS=$*' \
		$< 2>&1 | tee /dev/stderr | grep -qP 'Objects:\s+2'

stls/convex_remix_R%.3mf: radius_gauge.scad
	@mkdir ./stls/ 2>/dev/null || true
	$(OPENSCAD) -o $@ --enable lazy-union \
		-D 'FLIP=true' \
		-D 'TYPE="convex"' \
		-D 'TAB=true' \
		-D 'BASE_WIDTH=34.9' \
		-D 'CHAMFER_WIDTH=2' \
		-D 'RADIUS=$*' \
		$< 2>&1 | tee /dev/stderr | grep -qP 'Objects:\s+2'
