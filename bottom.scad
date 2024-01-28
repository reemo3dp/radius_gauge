use <overpass-extrabold.ttf>;
use <chamfers.scad>;

NUM = 30;

BASE_WALL_THICKNESS=2.6;
SLOT_DEPTH=35.55;
SLOT_WIDTH=2.35;
SLOT_HEIGHT=8;
SLOT_WALL=0.85;

SLOTS_WIDTH = NUM*SLOT_WIDTH + (NUM-1)*SLOT_WALL;
BASE_WIDTH=SLOTS_WIDTH+4.92501*2;
SLOTS_DEPTH = SLOT_DEPTH;
BASE_DEPTH=SLOTS_DEPTH+4.72500*2;

WITH_CUTOUT=false;


difference() {
    union() {
        translate([0, BASE_DEPTH, 0.5]) rotate([180, 0, 0]) 3d_chamfer(BASE_WIDTH, BASE_DEPTH, 2.82843, BASE_WIDTH-1, BASE_DEPTH-1, 2.41421, 0.5);
        
        translate([0, 0, 0.5]) linear_extrude(height = 4.5) 2d_chamfer(BASE_WIDTH, BASE_DEPTH, sqrt(pow(2.82843, 2)/2));
        
        translate([BASE_WALL_THICKNESS, BASE_WALL_THICKNESS, 0.5+4.5]) linear_extrude(height = 4.6) 2d_chamfer(BASE_WIDTH-2*BASE_WALL_THICKNESS, BASE_DEPTH-2*BASE_WALL_THICKNESS, sqrt(pow(2.74559, 2)/2));
        translate([BASE_WALL_THICKNESS, BASE_WALL_THICKNESS, 5+4.6]) 3d_chamfer(BASE_WIDTH-2*BASE_WALL_THICKNESS, BASE_DEPTH-2*BASE_WALL_THICKNESS, 2.75, BASE_WIDTH-2*BASE_WALL_THICKNESS-0.8,BASE_DEPTH-2*BASE_WALL_THICKNESS-0.8, 2.41421, 0.4);
    };
    slots();
};

module slots() {
    for(i = [0 : NUM-1]) {
        translate([4.92500+i*(SLOT_WIDTH+SLOT_WALL), 4.72500, 10-SLOT_HEIGHT]) slot();
    }
}

module slot() {
    if(WITH_CUTOUT) {
        union() {
            cube([SLOT_WIDTH, SLOT_DEPTH+2.125, SLOT_HEIGHT]);
            translate([0, SLOT_DEPTH+2.125, 0]) rotate([45, 0, 0]) cube([SLOT_WIDTH, 1, 1]);
            translate([0, SLOT_DEPTH+2.125, sqrt(2)/2]) cube([SLOT_WIDTH, sqrt(2)/2, SLOT_HEIGHT-sqrt(2)/2]);
        }
    } else {
        difference() {
            cube([SLOT_WIDTH, SLOT_DEPTH+2.125, SLOT_HEIGHT]);
            translate([0, SLOT_DEPTH+2.125, -sqrt(2)/2]) rotate([45, 0, 0]) cube([SLOT_WIDTH, 1, 1]);
        }
    }
}


