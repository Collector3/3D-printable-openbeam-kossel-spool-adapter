// Openbeam Kossel Pro mount for Replicator 2 spool holders
// Compatible spool holder: http://www.thingiverse.com/thing:44906
// License: CC1.0 Universal

$fn=60;

mater_thickness 	   = 3;
mater_length    	   = 67;
mater_width     	   = 28;

num_drills = 3;
drill_size = 3.7;
inset_depth = 1.5;
drill_depth = 3;

module drills(num_drills) {
	for ( i = [ 1 : num_drills ] ) {
		// Horizontal orientation
		if(i % 2 == 1) { // Don't do even numbered drills
		 	translate([mater_width/2.8, i*(mater_width/4), -1]) cylinder(r=drill_size/2, h=drill_depth);
        	translate([mater_width/2.8, i*(mater_width/4), -2]) cylinder(r=drill_size/1.2, h=inset_depth);
        }

  	    // Vertical orientation
		translate([i*10, mater_width/2, -1]) cylinder(r=drill_size/2, h=drill_depth);
		translate([i*10, mater_width/2, -2]) cylinder(r=drill_size/1.2, h=inset_depth);
	} // endfor
}

// shift geometry a bit so we can add side paneling without changing
// measurement references from origin
difference() {
	union() {
		// panel closest to origin..
		// acts as a retention lip when the holder is pulled down
		// by gravity
		// v0.02: Increase retention height for a more secure fit
		translate([0, 1.5, 30]) cube([14, .5, 2.5]);
	
		// panel opposite side
		translate([0, mater_width+1.5, 0]) cube([14, .5, 70]); 

		translate([0,1.5,0]) difference() {
			union() {
				// base bracket (attached to OpenBeam)
				cube([mater_thickness,mater_width,mater_length]);

				// top lip
				// v0.02: Increase size of top lip for better retention
				#translate([9, 0, 60.5]) cube([5, mater_width, 7.50]);
				// top catch plate
				translate([0, 0, mater_length]) cube([14, mater_width, 3]);

				// bottom lip
				translate([9, 0, 29]) cube([5, mater_width, 10]);
				// bottom catch plate
				translate([3, 0, 0]) cube([11, mater_width, 30]);
			} //end union
			translate([1.1, 0, 32]) rotate([0, 270, 0]) drills(num_drills);
		} //end difference
	} //end union
	// Corrective geometry for offsets if needed
	// Inner shape
 	//translate([0,1.5,0]) translate([3, 0, 30]) cube([9.5, 27, 38]);
} //end difference