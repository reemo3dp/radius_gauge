use <overpass-extrabold.ttf>;
include <chamfers.scad>;

NUM = 30;
TYPE = "concave";

INCLUDE_TEXT=true;

BASE_WALL_THICKNESS=2.4;
SLOT_DEPTH=35.55;
SLOT_WIDTH=2.35;
SLOT_HEIGHT=8;
SLOT_WALL=0.85;

SLOTS_WIDTH = NUM*SLOT_WIDTH + (NUM-1)*SLOT_WALL;
BASE_WIDTH=SLOTS_WIDTH+4.92501*2;
SLOTS_DEPTH = SLOT_DEPTH;
BASE_DEPTH=SLOTS_DEPTH+4.72500*2;


difference() {
    union() {
      hull() {
        translate([2, 2, 0]) cube([BASE_WIDTH-4, BASE_DEPTH-4, FUDGE]);
        translate([0, 0, 2-FUDGE]) linear_extrude(height = FUDGE) 2d_chamfer(BASE_WIDTH, BASE_DEPTH, 2);
      };
      translate([0, 0, 2]) linear_extrude(height = 34) 2d_chamfer(BASE_WIDTH, BASE_DEPTH, 2);
    };
    translate([BASE_WALL_THICKNESS, BASE_WALL_THICKNESS, 3]) linear_extrude(height = 33) 2d_chamfer(BASE_WIDTH-BASE_WALL_THICKNESS*2, BASE_DEPTH-BASE_WALL_THICKNESS*2, 2);   
    translate([1.9, BASE_DEPTH-1.9, 36]) rotate([180, 0, 0]) 3d_chamfer(BASE_WIDTH-1.9*2, BASE_DEPTH-1.9*2, 3.24264, BASE_WIDTH-BASE_WALL_THICKNESS*2, BASE_DEPTH-BASE_WALL_THICKNESS*2, 2.82843, 0.5);
    translate([BASE_WIDTH/2, BASE_DEPTH/2, 0]) mod_text();
}

if(INCLUDE_TEXT) {
  translate([BASE_WIDTH/2, BASE_DEPTH/2, -FUDGE]) mod_text();
}

module mod_text() {
    translate([0, 0, 0.3]) rotate([180, 0, 0]) linear_extrude(height = 0.3) {
        translate([0, 6, 0]) text("Radius Gauge", size = 10, font = "Overpass:style=ExtraBold", halign = "center", valign="center", $fn = 1000);
        translate([0, -8, 0]) text(typeStr(), size = 8, font = "Overpass:style=ExtraBold", halign = "center", valign="center", $fn = 1000);
    }
}


function typeStr() = str(
    TYPE == "concave" ? "concave |(" : "convex |)",
    " ",
    "R1-",
    NUM
    );
