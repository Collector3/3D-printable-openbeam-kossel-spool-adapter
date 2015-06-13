// Openbeam Kossel Pro mount for Replicator 2 spool holders
// Compatible spool holder: http://www.thingiverse.com/thing:44906
// License: CC0 1.0 Universal

$fn=60;

mater_thickness 	   = 3;
mater_length    	   = 68;
mater_width     	   = 28;

drill_size            = 3.7;
inset_depth           = 1.5;
drill_depth           = 3;

retainer_plate_offset = 1;

module drill_hit() {
	   // Vertical hits
	   translate([0, mater_width/2, -1]) cylinder(r=drill_size/2,   h=drill_depth);
	   translate([0, mater_width/2, -2]) cylinder(r=drill_size/1.2, h=inset_depth);
}

// Shift geometry a bit so we can add side paneling without changing
// measurement references from origin
difference() {
	union() {
		// Retainer panel closest to origin..
		translate([0, 1.5, 0]) cube([14, retainer_plate_offset, 70]); 

		// Retainer panel opposite side
		translate([0, mater_width+1.5, 0]) cube([14, retainer_plate_offset, 70]); 

		translate([0,1.5,0]) 
		difference() {
			union() {
				// Base bracket (attached to OpenBeam)
				cube([mater_thickness,mater_width,mater_length]);

				// Top lip, catch plate
				translate([10, 0, mater_length+1]) mirror([0, 0, 1]) 
					rotate([0, 30, 0]) cube([3.5, mater_width+retainer_plate_offset, 8]);

				// Top barrier plate, +.5 to match side retainer plates
				translate([0, 0, mater_length]) cube([14, mater_width+retainer_plate_offset, 3]);

				// Bottom lip (internal holder area)
				translate([9, 0, 29]) rotate([0, 0, 0]) cube([5, mater_width, 10]);

				// Bottom catch plate and bottom screw hollow area
				translate([3, retainer_plate_offset, 0]) {
					difference() {
						cube([11, mater_width, 30]);
						#translate([0, 0, mater_thickness]) cube([11.5, mater_width-1, 22]);
					}
				}


				// TODO: 45 deg support for internal bottom catch plate
			} //end union

			// Drill hits -- the end user does not need to screw all of these in
			// for stability but they're here for extra configurability.
			
			translate([1.5, 0, 8])  rotate([0, 270, 0]) drill_hit();
			translate([1.5, 0, 20]) rotate([0, 270, 0]) drill_hit();
			translate([1.5, 0, 43]) rotate([0, 270, 0]) drill_hit();
			translate([1.5, 0, 55]) rotate([0, 270, 0]) drill_hit();

		} //end difference
	} //end union

	// Corrective geometry for offsets if needed
	// Inner shape
 	//translate([0,1.5,0]) translate([3, 0, 30]) cube([9.5, 27, 38]);

} //end difference