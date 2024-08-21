realH = 50;
fakeH = 100;
thickness= 3;
l=2;
diameter = 100;

$fn=100;

inPot();

module pot(){
    difference(){
    dcylinder(h = fakeH, d = diameter,s = l);
        
        translate([thickness,thickness,thickness])
        dcylinder(h = fakeH, d = diameter-thickness*2, s= l);
    }
}

module inPot(){
    difference(){
        dcylinder(h = realH, d = diameter-thickness*2,s = l);
        translate([thickness,thickness,thickness])
            dcylinder(h = realH, d = diameter-thickness*4, s= l);
    }
}

module dcylinder(d,h,s){
    intersection(){
        translate([d/2,d/2,0])
        cylinder(h=h,d=d);
        cube([d,d-s,h]);
    }
}