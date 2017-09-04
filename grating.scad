

/* Defaults produce hex mesh. rad .75, fac 20 produces circle-perforated metal. */
module perforated(rad=1.25, ang=30, fac=6) {
  difference() {
    translate([0,0,-.25]) cube([50,50,.5]);

    for (x = [0:19], y = [0:24]) {
      if (y%2) {
        translate([x*3 + 1.5, y*2.5, -1]) rotate([0,0,ang]) cylinder(r=rad, h=2, $fn=fac);
      }
      else {
        translate([x*3, y*2.5, -1]) rotate([0,0,-ang]) cylinder(r=rad, h=2, $fn=fac);
      }
    }
  }
}

module woven() {
}

module expanded() {
  difference() {
    translate([0,0,-.25]) cube([50,50,.5]);

    for (x = [0:19], y = [0:24]) {
      if (y%2) {
        translate([x*3 + 1.5, y*2.5, -1]) expandedShape();
      }
      else {
        translate([x*3, y*2.5, -1]) expandedShape();
      }
    }
  }
}


module expandedShape() {
  linear_extrude(2) scale([2, 2]) polygon([[.5,2], [1,1.2], [1,.8], [.5,0], [0,.8], [0,1.2]]);
}