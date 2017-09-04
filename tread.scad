module treadPlate(shape="smooth") {
  for (x = [0:19], y = [0:24]) {
    if (y%2) {
      translate([x*3.5 + 1.75, y*2]) rotate([0,0,45]) diamond(shape);
    }
    else {
      translate([x*3.5, y*2]) rotate([0,0,-45]) diamond(shape);
    }
  }
  translate([0,0,-.25]) cube([50,50,.25]);
}



module diamond(p="sharp") {
  if (p == "sharp") {
    scale([.5,.5,.5]) sharpDiamond();
  }
  else if (p == "smooth") {
    scale([.5,.5,.5]) smoothDiamond();
  }
  else {
    scale([.5,.5,.5]) treadPattern();
  }
}

module sharpDiamond() {
  linear_extrude(height=.5, scale=.9)
  union() {
    circle(d=1.5, $fn=25);
    intersection() {
      translate([-9.5,0]) circle(d=20, $fn=50);
      translate([9.5,0]) circle(d=20, $fn=50);
    }
  }
}

module smoothDiamond() {
  linear_extrude(height=.5, scale=.9)
  hull() {
    scale([1,2,1]) circle(d=1.5, $fn=25);
    intersection() {
      translate([-9.5,0]) circle(d=20, $fn=50);
      translate([9.5,0]) circle(d=20, $fn=50);
    }
  }
}



module treadPattern() {
  linear_extrude(height=.5, scale=.9)
  intersection() {
    translate([-14.25,0]) circle(d=30, $fn=100);
    translate([14.25,0]) circle(d=30, $fn=100);
    square([10,6], center=true);
  }
}