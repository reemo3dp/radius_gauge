RADIUS=5; // Overwrite with -D RADIUS=$X
TAB=false; // Overwrite with -D TAB=true
use <radius_gauge.scad>;
gauge_concave(RADIUS);
module_text(RADIUS);
