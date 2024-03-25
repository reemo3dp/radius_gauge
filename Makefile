OPENSCAD ?= openscad

.PHONY: all clean

clean:
	rm -rf stls/

all: \
	stls/remix_bottom.3mf \
	stls/remix_top_concave.3mf \
	stls/remix_top_convex.3mf \
	stls/remix_top_no_text_concave.3mf \
	stls/remix_top_no_text_convex.3mf \
    $(patsubst %,stls/classic_concave_R%.3mf,$(shell seq 1 30)) \
	$(patsubst %,stls/classic_convex_R%.3mf,$(shell seq 1 30)) \
    $(patsubst %,stls/classic_no_text_concave_R%.3mf,$(shell seq 1 30)) \
	$(patsubst %,stls/classic_no_text_convex_R%.3mf,$(shell seq 1 30)) \
    $(patsubst %,stls/remix_no_text_concave_R%.3mf,$(shell seq 1 30)) \
	$(patsubst %,stls/remix_no_text_convex_R%.3mf,$(shell seq 1 30)) \
    $(patsubst %,stls/remix_concave_R%.3mf,$(shell seq 1 30)) \
	$(patsubst %,stls/remix_convex_R%.3mf,$(shell seq 1 30)) 

stls/classic_no_text_concave_R%.3mf: radius_gauge.scad
	@mkdir ./stls/ 2>/dev/null || true
	$(OPENSCAD) -o $@ --enable lazy-union \
		-D 'FLIP=true' \
		-D 'TYPE="concave"' \
		-D 'TAB=false' \
		-D 'ROTATE_TEXT=false' \
		-D 'BASE_WIDTH=35' \
		-D 'CHAMFER_WIDTH=1' \
		-D 'RADIUS=$*' \
		-D 'INCLUDE_TEXT=false' \
		$< 

stls/classic_no_text_convex_R%.3mf: radius_gauge.scad
	@mkdir ./stls/ 2>/dev/null || true
	$(OPENSCAD) -o $@ --enable lazy-union \
		-D 'FLIP=true' \
		-D 'TYPE="convex"' \
		-D 'TAB=false' \
		-D 'ROTATE_TEXT=false' \
		-D 'BASE_WIDTH=35' \
		-D 'CHAMFER_WIDTH=1' \
		-D 'RADIUS=$*' \
		-D 'INCLUDE_TEXT=false' \
		$< 

stls/classic_concave_R%.3mf: radius_gauge.scad
	@mkdir ./stls/ 2>/dev/null || true
	$(OPENSCAD) -o $@ --enable lazy-union \
		-D 'FLIP=true' \
		-D 'TYPE="concave"' \
		-D 'TAB=false' \
		-D 'ROTATE_TEXT=false' \
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
		-D 'ROTATE_TEXT=false' \
		-D 'BASE_WIDTH=35' \
		-D 'CHAMFER_WIDTH=1' \
		-D 'RADIUS=$*' \
		$< 2>&1 | tee /dev/stderr | grep -qP 'Objects:\s+2'

stls/remix_concave_R%.3mf: radius_gauge.scad
	@mkdir ./stls/ 2>/dev/null || true
	$(OPENSCAD) -o $@ --enable lazy-union \
		-D 'FLIP=true' \
		-D 'TYPE="concave"' \
		-D 'TAB=true' \
		-D 'ROTATE_TEXT=true' \
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
		-D 'ROTATE_TEXT=true' \
		-D 'BASE_WIDTH=34.9' \
		-D 'CHAMFER_WIDTH=2' \
		-D 'RADIUS=$*' \
		$< 2>&1 | tee /dev/stderr | grep -qP 'Objects:\s+2'

stls/remix_no_text_concave_R%.3mf: radius_gauge.scad
	@mkdir ./stls/ 2>/dev/null || true
	$(OPENSCAD) -o $@ --enable lazy-union \
		-D 'FLIP=true' \
		-D 'TYPE="concave"' \
		-D 'TAB=true' \
		-D 'ROTATE_TEXT=true' \
		-D 'BASE_WIDTH=34.9' \
		-D 'CHAMFER_WIDTH=2' \
		-D 'RADIUS=$*' \
		-D 'INCLUDE_TEXT=false' \
		$< 

stls/remix_no_text_convex_R%.3mf: radius_gauge.scad
	@mkdir ./stls/ 2>/dev/null || true
	$(OPENSCAD) -o $@ --enable lazy-union \
		-D 'FLIP=true' \
		-D 'TYPE="convex"' \
		-D 'TAB=true' \
		-D 'ROTATE_TEXT=true' \
		-D 'BASE_WIDTH=34.9' \
		-D 'CHAMFER_WIDTH=2' \
		-D 'RADIUS=$*' \
		-D 'INCLUDE_TEXT=false' \
		$< 

bottom.scad top.scad: chamfers.scad
top.scad: chamfers.scad

stls/remix_bottom.3mf: bottom.scad
	@mkdir ./stls/ 2>/dev/null || true
	$(OPENSCAD) -o $@ $< 2>&1 

stls/remix_top_%.3mf: top.scad
	@mkdir ./stls/ 2>/dev/null || true
	$(OPENSCAD) -o $@ --enable lazy-union \
		-D 'TYPE="$*"' \
		$< 2>&1 | tee /dev/stderr | grep -qP 'Objects:\s+2'

stls/remix_top_no_text_%.3mf: top.scad
	@mkdir ./stls/ 2>/dev/null || true
	$(OPENSCAD) -o $@ --enable lazy-union \
		-D 'TYPE="$*"' \
		-D 'INCLUDE_TEXT=false' \
		$< 
