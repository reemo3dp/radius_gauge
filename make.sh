#!/bin/bash

set -euxo pipefail

OPENSCAD=~/Applications/OpenSCAD-2024.01.23.ai18238-x86_64.AppImage
OPENSCAD_OPTS="--enable lazy-union"

mkdir -p output || true

# For i in 1 to 30
for i in {1..30}
do
    # shellcheck disable=SC2086
    $OPENSCAD $OPENSCAD_OPTS -o "output/concave_R${i}.3mf" -D "RADIUS=${i}" "./concave.scad"
    # shellcheck disable=SC2086
    $OPENSCAD $OPENSCAD_OPTS -o "output/convex_R${i}.3mf" -D "RADIUS=${i}" "./convex.scad"
done