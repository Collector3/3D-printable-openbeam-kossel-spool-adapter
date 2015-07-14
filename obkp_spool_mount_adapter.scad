// Openbeam (Kossel Pro) mount for Replicator 2 spool holders
// Mating spool holder: http://www.thingiverse.com/thing:44906
// License: CC0 1.0 Universal


$fn=60;

mater_thickness       = 3;
mater_length          = 70.8;
mater_width           = 30;
mater_depth            = 23;

drill_size             = 4.5;
inset_depth            = 1.5;
drill_depth            = 3;

retainer_plate_offset  = 1.5;
bottom_cutout_amount_y = 7;
bottom_cutout_amount_z = 25;
base_height            = 2.5;

top_catch_plate_height = 2.5;

module front_drill_hit(d2_depth=12,height=mater_depth+drill_depth) {
    translate([0, mater_width/2, 0]) cylinder(r=drill_size/2.4, h=height, d2 = d2_depth);
}

module side_drill_hit() {
    translate([0, mater_width/2, 0]) cylinder(r=2.8, h=11);
}

union() {
    // For drill hits
    difference() {
        // Main body
        union() {            
            // Retainer panel closest to origin..
            translate([0, 0, 0]) cube([mater_depth, retainer_plate_offset, mater_length]);

            // Retainer panel opposite side
            translate([0, mater_width, 0]) cube([mater_depth, retainer_plate_offset, mater_length]);

            // 30 degree flange -- origin side
            difference() {              
                union() {
                   // Flat facing openbeam at angle for straightened spool holder
                  translate([0, 0, 32]) rotate(-30) {
                        cube([13, 5, mater_length-(base_height+bottom_cutout_amount_z)+top_catch_plate_height-10]);
                   }
                   
                   // Outward angle matched against beam during side mounting
                   translate([mater_depth, 0, base_height+bottom_cutout_amount_z]) rotate(30) translate([-14,0,0]) {
                        cube([14, 9,mater_length-(base_height+bottom_cutout_amount_z)+top_catch_plate_height]);
                   }
                }

                translate([mater_depth,0,base_height+bottom_cutout_amount_z]) translate([-25,0,0]) {
                    cube([25, 10,mater_length-(base_height+bottom_cutout_amount_z)+top_catch_plate_height]);
                }
            }
            
            // 30 degree flange -- opposite origin
            difference() {
               union() {
                    // Flat facing openbeam at angle for straightened spool holder 
                    translate([2.5, mater_width-2.83, 32]) rotate(30) {
                        cube([13, 5, mater_length-(base_height+bottom_cutout_amount_z)+top_catch_plate_height-10]);
                    }
                    
                    // Outward angle matched against beam during side mounting
                    translate([mater_depth,mater_width+retainer_plate_offset, base_height+bottom_cutout_amount_z]) {
                        rotate(150) cube([14, 9,mater_length-(base_height+bottom_cutout_amount_z)+top_catch_plate_height]);
                    }
                }

                translate([mater_depth-25, mater_width+retainer_plate_offset-10, base_height+bottom_cutout_amount_z]) {
                    cube([25, 10,mater_length-(base_height+bottom_cutout_amount_z)+top_catch_plate_height]);
                }

            }

            // Base bracket (attached to OpenBeam)
            cube([mater_depth,mater_width,30]);

            union() {
                // Top lip, angled catch plate
                translate([mater_depth-6.50, .5, mater_length-7]) mirror([0, 0, 1])
                    rotate([0, 40, 0]) cube([5.8, mater_width+retainer_plate_offset/2, 3.2]);

                // Connective block to top lip
                translate([mater_depth-6.50, .5, mater_length-7])
                    cube([6.50, mater_width+retainer_plate_offset/2, 7]);
            } // .. union

            // Top barrier plate
            translate([0, 0, mater_length]) cube([mater_depth, mater_width+retainer_plate_offset, top_catch_plate_height]);

            // Bottom lip (internal holder area)
            translate([mater_depth-5, 1, 30]) cube([5, mater_width, 8.5]);

            // Bottom catch plate and bottom screw hollow area
            translate([3, retainer_plate_offset, 0]) {
                difference() {
                    cube([11, mater_width, 30]);
                    translate([0, 0, mater_thickness]) cube([11.5, mater_width-1, 22]);
                } // .. difference
            } // .. translate
        } // .. union

    // Drill hits
    translate([-2, 1, 8])  mirror(1) rotate([0, 270, 0]) front_drill_hit();
    translate([-2, 1, 22]) mirror(1) rotate([0, 270, 0]) front_drill_hit();

    // Side drill hits
    // Left panel
    #translate([3, -5, 32]) rotate(150) rotate([90, 0, 0]) side_drill_hit();
    #translate([3, -5, 25]) rotate(150) rotate([90, 0, 0]) side_drill_hit();

    // Right panel
    #translate([3,mater_width+retainer_plate_offset+5,32]) rotate(30) rotate([90, 0, 0]) side_drill_hit();
    #translate([3,mater_width+retainer_plate_offset+5,25]) rotate(30) rotate([90, 0, 0]) side_drill_hit();

    /// Slots at bottom to save filament/printing time.
    // Left:
    translate([0, 0, base_height]) {
        cube([mater_depth, bottom_cutout_amount_y, bottom_cutout_amount_z]);
    } // .. translate

    // Right:
    translate([0, mater_width-bottom_cutout_amount_y+retainer_plate_offset, base_height]) {
        cube([mater_depth, bottom_cutout_amount_y, bottom_cutout_amount_z]);
        
    } // .. translate
  } // .. difference
} // .. union
