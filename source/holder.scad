
use <bolts.scad>;
use <zcube.scad>;

$fn = $preview ? 24 : 128;

function offset(diameter, i) = diameter * 4 * i;

module body(diameter, repeats) {
	difference() {
		hull()
		for (i = [0:repeats-1]) {
			translate([offset(diameter, i), diameter*0.5, diameter/2]) {
				translate([0, -diameter/2, 0]) rotate([20, 0, 0])
				cube([diameter*1.5, diameter*2, diameter*1.5], center=true);
				cube([diameter*2, diameter*2, diameter*1.5], center=true);
			}
		}
		
		// Bottom:
		zcube([offset(diameter, repeats+1), diameter * 4, diameter * 4], f=-1);
	}
}

module squeeze(minimum = 10, maximum = 16) {
	hull() {
		translate([0, 0, -minimum])
		cylinder(d=minimum);
		
		translate([0, 0, maximum*2])
		cylinder(d=maximum);
	}
}

module toothbrush(diameter, repeats) {
	for (i = [0:repeats-1]) {
		translate([offset(diameter, i), -diameter/2, 0]) {
			hull() {
				squeeze();
				
				translate([0, -diameter, 0])
				squeeze(minimum=6);
			}
		}
	}
}

module clip(diameter, repeats) {
	size = offset(diameter, repeats+1);
	
	translate([0, diameter, -5]) {
		hull() {
			translate([-size/2, 0, 15]) rotate([0, 90, 0])
			cylinder_outer(size, 3);
			zcube([size, 6, 1]);
		}
	}
}

module holder(diameter = 12.2, repeats=1) {
	difference() {
		minkowski() {
			sphere(d=5);
			body(diameter, repeats);
		}
		
		toothbrush(diameter, repeats);
		
		// Clip:
		clip(diameter, repeats);
	}
}

holder();
