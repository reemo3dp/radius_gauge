OPENSCAD ?= openscad

.PHONY: all clean

clean:
	rm -rf stls/

all: \
    $(patsubst %,stls/classic_concave_R%.3mf,$(shell seq 1 30)) \
	$(patsubst %,stls/classic_convex_R%.3mf,$(shell seq 1 30)) \
    $(patsubst %,stls/remix_concave_R%.3mf,$(shell seq 1 30)) \
	$(patsubst %,stls/remix_convex_R%.3mf,$(shell seq 1 30)) 

stls/classic_concave_R%.3mf: radius_gauge.scad
	@mkdir ./stls/ 2>/dev/null || true
	$(OPENSCAD) -o $@ --enable lazy-union \
		-D 'FLIP=true' \
		-D 'TYPE="concave"' \
		-D 'TAB=false' \
		-D 'BASE_WIDTH=35' \
		-D 'CHAMFER_WIDTH=1' \
		-D 'RADIUS=$*' \
		$< 2>&1 | tee /dev/stderr | grep -qP 'Objects:\s+2'

stls/classic_convex_R%.3mf: radius_gauge.scad
	@mkdir ./stls/ 2>/dev/null || true
	$(OPENSCAD) -o $@ --enable lazy-union \
		-D 'FLIP=true' \
		-D 'TYPE="convex"' \
		-D 'TAB=false' \
		-D 'BASE_WIDTH=35' \
		-D 'CHAMFER_WIDTH=1' \
		-D 'RADIUS=$*' \
		$< 2>&1 | tee /dev/stderr | grep -qP 'Objects:\s+2'

stls/remix_concave_R%.3mf: radius_gauge.scad
	@mkdir ./stls/ 2>/dev/null || true
	$(OPENSCAD) -o $@ --enable lazy-union \
		-D 'FLIP=true' \
		-D 'TYPE="convex"' \
		-D 'TAB=true' \
		-D 'BASE_WIDTH=34.9' \
		-D 'CHAMFER_WIDTH=2' \
		-D 'RADIUS=$*' \
		$< 2>&1 | tee /dev/stderr | grep -qP 'Objects:\s+2'

stls/remix_convex_R%.3mf: radius_gauge.scad
	@mkdir ./stls/ 2>/dev/null || true
	$(OPENSCAD) -o $@ --enable lazy-union \
		-D 'FLIP=true' \
		-D 'TYPE="convex"' \
		-D 'TAB=true' \
		-D 'BASE_WIDTH=34.9' \
		-D 'CHAMFER_WIDTH=2' \
		-D 'RADIUS=$*' \
		$< 2>&1 | tee /dev/stderr | grep -qP 'Objects:\s+2'
