FUDGE=0.0001;

module 3d_chamfer(bottomW, bottomD, bottomSideChamfer, topW, topD, topSideChamfer, height) {
    hull() {
        linear_extrude(height = FUDGE) 2d_chamfer(bottomW, bottomD, sqrt(pow(bottomSideChamfer, 2)/2));
        translate([(topW/bottomW)/2, (topD/bottomD)/2, height-FUDGE]) linear_extrude(height = FUDGE) 2d_chamfer(topW, topD, sqrt(pow(topSideChamfer, 2)/2));
    }
}

module 2d_chamfer(bottomW, bottomD, radius) {
    polygon([
            [radius, 0], 
            [0, radius], 
            [0, bottomD-radius], 
            [radius, bottomD],
            [bottomW-radius, bottomD],
            [bottomW, bottomD-radius],
            [bottomW, radius],
            [bottomW-radius, 0]
        ]);
}


