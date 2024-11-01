use <overpass-extrabold.ttf>;

RADIUS=30; // Overwrite with -D RADIUS=$X
TAB=true; // Overwrite with -D TAB=true
TYPE="convex"; // Overwrite with -D TYPE=convex
FLIP=false;
BASE_WIDTH=34.9;
CHAMFER_WIDTH=2;
ROTATE_TEXT=true;
INCLUDE_TEXT=true;
TEXT_DEPTH=INCLUDE_TEXT ? 0.3 : 0.4;

if(TYPE == "concave") {
    rotate([0,FLIP ? 180 : 0,0]) gauge_concave(BASE_WIDTH, RADIUS, CHAMFER_WIDTH, TAB);
} else {
    rotate([0,FLIP ? 180 : 0,0]) gauge_convex(BASE_WIDTH, RADIUS, CHAMFER_WIDTH, TAB);
}

if(INCLUDE_TEXT) {
    rotate([0,FLIP ? 180 : 0,0]) module_text(BASE_WIDTH, RADIUS);
}



module gauge_concave(baseWidth, radius, chamferWidth, tab) {
    difference() {
        base(baseWidth, chamferWidth, tab);
        translate([0, baseWidth, 1]) cylinder(h = 2, r = radius, center = true, $fn = 1000);
        if(ROTATE_TEXT) {
            translate([baseWidth-2, 4, 2-TEXT_DEPTH]) linear_extrude(TEXT_DEPTH) rotate([0, 0, 90]) radius_text(baseWidth, radius, halign="left");
        } else {
            translate([baseWidth-2, 4, 2-TEXT_DEPTH]) linear_extrude(TEXT_DEPTH) radius_text(baseWidth, radius);
        }
    };
};

module gauge_convex(baseWidth, radius, chamferWidth, tab) {
    difference() {
        base(baseWidth, chamferWidth, tab);
        translate([radius, baseWidth-radius, 0]) rotate([0, 0, 90]) difference() {
            cube([RADIUS, RADIUS, 2]);
            intersection() {
                cube([RADIUS, RADIUS, 2]);
                cylinder(h = 2, r = RADIUS, $fn = 1000);
            };
        };
        if(ROTATE_TEXT) {
            translate([baseWidth-2, 4, 2-TEXT_DEPTH]) linear_extrude(TEXT_DEPTH) rotate([0, 0, 90]) radius_text(baseWidth, radius, halign="left");
        } else {
            translate([baseWidth-2, 4, 2-TEXT_DEPTH]) linear_extrude(TEXT_DEPTH) radius_text(baseWidth, radius);
        }
    };
};


module radius_text(baseWidth, radius, halign = "right") {
    text(padded_str(radius), size = 6, font = "Overpass:style=ExtraBold", halign = halign, $fn = 1000);
}

module base(baseWidth, chamferWidth, withTab) {
    difference() {
        union() {
            cube([baseWidth, baseWidth, 2]);
            if(withTab) {
                tab(baseWidth);
            }
        }
        translate([0, 0, 0]) chamfer(chamferWidth);
        translate([baseWidth, baseWidth, 0]) chamfer(chamferWidth);
        translate([baseWidth, 0, 0]) chamfer(chamferWidth);    
    };
}

module tab(baseWidth) {
    translate([baseWidth, 16, 0]) union() {
        cube([1.7, 10, 2]);
        chamfer(2.404163056);
        translate([0, 10, 0]) chamfer(2.404163056);
    };
}

module chamfer(chamferWidth) {
    rotate([0, 0, 45]) translate([-chamferWidth/2, -chamferWidth/2, 0]) cube([chamferWidth, chamferWidth, 2]);    
}

function padded_str(radius) = str("R", leftpad(radius, 2));

function leftpad(num, digits) = num >= pow(10, digits-1) ? str(num) : str("0", leftpad(num, digits-1));



module module_text(baseWidth, r) {
    if(ROTATE_TEXT) {
        color("red") translate([baseWidth-2, 4, 2.001-TEXT_DEPTH]) rotate([0, 0, 90]) linear_extrude(TEXT_DEPTH) radius_text(baseWidth, r, halign="left");
    } else {
        color("red") translate([baseWidth-2, 4, 2.001-TEXT_DEPTH]) linear_extrude(TEXT_DEPTH) radius_text(baseWidth, r);
    }
}

