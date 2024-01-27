use <overpass-extrabold.ttf>;

module gauge_concave(radius) {
    difference() {
        base();
        translate([0, 35, 1]) cylinder(h = 2, r = radius, center = true, $fn = 1000);
        translate([33, 4, 1.7]) linear_extrude(0.3) radius_text(radius);
    };
};

module gauge_convex(radius) {
    difference() {
        base();
        translate([radius, 35-radius, 0]) rotate([0, 0, 90]) difference() {
            cube([RADIUS, RADIUS, 2]);
            intersection() {
                cube([RADIUS, RADIUS, 2]);
                cylinder(h = 2, r = RADIUS, $fn = 1000);
            };
        };
        translate([33, 4, 1.7]) linear_extrude(0.3) radius_text(radius);
    };
};


module radius_text(radius) {
    text(padded_str(radius), size = 6, font = "Overpass:style=ExtraBold", halign = "right", $fn = 1000);
}

module base() {
    difference() {
        cube([35, 35, 2]);
        translate([0, 0, 0]) chamfer();
        translate([35, 35, 0]) chamfer();
        translate([35, 0, 0]) chamfer();    
    };
}

module chamfer() {
    rotate([0, 0, 45]) translate([-0.5, -0.5, 0]) cube([1, 1, 2]);    
}

function padded_str(radius) = str("R", leftpad(radius, 2));

function leftpad(num, digits) = num >= pow(10, digits-1) ? str(num) : str("0", leftpad(num, digits-1));



module module_text(r) {
    translate([33, 4, 1.701]) linear_extrude(0.3) radius_text(r);
}

