/*
 Wire = thickness of the mesh wire
 Pad = Additional gap between each wire
 Size = number of repetitions
 */

module mesh(wire=1, pad=1, size=10, quality=20) {
  l = segmentLength(wire, pad);
  translate([0,-l])
  for (z = [0,1]) {
    translate([l*z*size*2,l*z])
    rotate([0,0,90*z]) {
      for (x = [0:size*2-1], y = [0:size-1]) {
        translate([l*x, l*y*2 + x%2*l])
        rotate([0,90,0])
        link(wire, pad, quality);
      }
    }
  }
}

/* Angle necessary for everything to line up. */
function angle(wire, pad) = atan(wire/(2*wire + pad/2));
/* The width of the elbows. */
function wireOffset(wire, pad) = wire+pad/2;
/* The length of the wire connecting the elbows. */
function gapLength(wire, pad) = wire / sin(angle(wire, pad));
/* The length of a single elbow. We shave off a 100th of a mm to make things line up nicely. */
function elbowLength(wire, pad) = sin(angle(wire, pad)) * wire * .74;
/* The total length of the entire component. */
function segmentLength(wire, pad) = gapLength(wire, pad) + elbowLength(wire, pad) * 2;

module link(wire=1, pad=1, quality=25) {
  a = angle(wire, pad);
  union() {
    for (i=[0,1]) {
      translate([0,segmentLength(wire, pad)/2])
      translate([0,segmentLength(wire, pad) * i])
      rotate([0,180*i])
      rotate([0,0,-a]) {
        translate([0,gapLength(wire,pad)/2]) {
       
          translate([-wire,0])
            rotate_extrude(angle=a, $fn=quality)
              translate([wire, 0]) circle(d=wire, $fn=quality);

          rotate([0,180]) {
            translate([-wire,-gapLength(wire, pad)]) {
              translate([wire,gapLength(wire, pad),0]) rotate([90,0,0])
                cylinder(d=wire, h=gapLength(wire, pad), $fn=quality);
              
              rotate_extrude(angle=-a, $fn=quality)
                translate([wire, 0]) circle(d=wire, $fn=quality);
            }
          }
        }
      }
    }
  }
}
