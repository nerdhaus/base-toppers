use <grating.scad>
use <tread.scad>
use <mesh.scad>

makeTextureBase();

module makePlates() {
  translate([0,0,0]) perforated();
  translate([0,60,0]) perforated(rad=.75, fac=20);
  translate([0,120,0]) expanded();
  translate([60,0,0]) treadPlate(shape="smooth");
  translate([60,60,0]) treadPlate(shape="tread");
  translate([60,120,0]) mesh();
}


module makeTextureBase(size=25) {
  intersection() {
    translate([size/2,size/2,-2]) cylinder(d=size-1, h=4);
    mesh(wire=.5, quality=6);
    
    /*
    perforated(rad=1.25, ang=30, fac=6);
    expanded();
    treadPlate(shape="smooth");
    */
  }
  /* Add the cap */
  translate([size/2,size/2,-.25]) rotate_extrude($fn=50) translate([(size/2)-1.5,0]) upperLipProfile();
  
  /* Add the bolts */
  for (i = [0:30:360]) {
    translate([size/2,size/2,.5]) rotate([0,0,i]) translate([0,size/2 - .75])
    rotate([0,0,45], center=true) cylinder(h=.5, d=1, $fn=6, center=true);
  }
}

module upperLipProfile() {
  hull() {
    polygon([[0,0], [1.5,0], [1.5, .75], [0, .75]]);    
  }
}