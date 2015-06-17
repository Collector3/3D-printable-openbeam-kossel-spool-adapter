// Openbeam Kossel Pro mount for Replicator 2 spool holders
// Compatible spool holder: http://www.thingiverse.com/thing:44906
// License: CC0 1.0 Universal

$fn=60;

mater_thickness 	  = 3;
mater_length    	  = 70.8;
mater_width     	  = 30;
mater_depth           = 22;

drill_size            = 4.5;
inset_depth           = 1.5;
drill_depth           = 3;

retainer_plate_offset = 2.5;
bottom_cutout_amount  = 7;

module drill_hit(d2_depth=12,height=mater_depth+drill_depth) {
       // screw
	   //#translate([0, mater_width/2, 0]) cylinder(r=drill_size/2,   h=drill_depth+mater_depth);
       // outer ring to capture screw head, approx larger by 1.15mm
	   //#translate([0, mater_width/2, drill_depth]) cylinder(r=drill_size/1.4, h=mater_depth, d2 = 10);
        translate([0, mater_width/2, 0]) cylinder(r=drill_size/2.4, h=height, d2 = d2_depth);
}



union() {
    difference() {
        union() {
             // Retainer panel closest to origin..
            translate([0, 0, 0]) cube([mater_depth, retainer_plate_offset, mater_length]); 

            // Retainer panel opposite side
            translate([0, mater_width, 0]) cube([mater_depth, retainer_plate_offset, mater_length]);
            
            // Base bracket (attached to OpenBeam)
            cube([mater_depth,mater_width,30]);
            
            union() {
                // Top lip, angled catch plate
                translate([mater_depth-6.50, .5, mater_length-7]) mirror([0, 0, 1]) 
                    rotate([0, 40, 0]) cube([5.8, mater_width+retainer_plate_offset/2, 3.2]);

                // Connective block to top lip
                translate([mater_depth-6.50, .5, mater_length-7]) 
                    cube([6.50, mater_width+retainer_plate_offset/2, 7]);
            }
            // Top barrier plate, +.5 to match side retainer plates
            translate([0, 0, mater_length]) cube([mater_depth, mater_width+retainer_plate_offset, 2]);
            
            // Bottom lip (internal holder area)
            translate([mater_depth-5, 1, 30]) cube([5, mater_width, 8.5]);

            // Bottom catch plate and bottom screw hollow area
            translate([3, retainer_plate_offset, 0]) {
                difference() {
                    cube([11, mater_width, 30]);
                    translate([0, 0, mater_thickness]) cube([11.5, mater_width-1, 22]);
                }
            }        
        } //end union

    // Drill hits			
    #translate([-2, 1, 8])  mirror(1) rotate([0, 270, 0]) drill_hit();
    #translate([-2, 1, 22]) mirror(1) rotate([0, 270, 0]) drill_hit();
        
    // Side drill hits 
    // Left panel
    #translate([5,retainer_plate_offset,40]) rotate([90, 0, 0]) drill_hit(5,3);
    #translate([5,retainer_plate_offset,26]) rotate([90, 0, 0]) drill_hit(5,3);    
        
    // Righ panel
    #translate([5,mater_width+retainer_plate_offset,40]) rotate([90, 0, 0]) drill_hit(5,3);
    #translate([5,mater_width+retainer_plate_offset,26]) rotate([90, 0, 0]) drill_hit(5,3);
        
    /// Holes to save filament/printing time.      
    // Left:
    translate([0, 0, 2.5]) 
        #cube([mater_depth, bottom_cutout_amount, 25]);

    // Right: 
    #translate([0, mater_width-bottom_cutout_amount+retainer_plate_offset, 2.5]) 
        cube([mater_depth, bottom_cutout_amount, 25]);
        
  } // end difference
} // end union