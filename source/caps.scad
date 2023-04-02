
use <bolts.scad>;

$fn = $preview ? 24 : 128;

module cap(diameter = 12.2, height = 10, letter = "H") {
	render()
	difference() {
		cylinder_outer(height, diameter/2 + 2);
		cylinder_inner(height - 2, diameter/2);
		
		text_size = diameter * 0.75;
		translate([0, 0, height - 1])
		linear_extrude(height = 4, center = true)
		text(letter, text_size, halign="center", valign="center");
	}
}


translate([0, 0, 0])
cap(letter = "A");

translate([20, 0, 0])
cap(letter = "S");

translate([40, 0, 0])
cap(letter = "H");

translate([60, 0, 0])
cap(letter = "K");
