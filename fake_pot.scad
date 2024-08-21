realH = 50;
fakeH = 100;
thickness= 3;
l=2;
diameter = 100;
drainOd = 10;
drainId = 5;
tolerance = 0.1;

$fn=100;

twoThickness = thickness * 2;
inDiam = diameter - twoThickness;

inPot();

module pot(){
    difference(){
        dcylinder(h = fakeH, d = diameter,s = l);
        
        translate([thickness,thickness,thickness])
        dcylinder(h = fakeH, d = inDiam, s= l);
    }
}

module inPot(){
    difference(){
        dcylinder(h = realH, d = inDiam-tolerance,s = l);
        translate([thickness,thickness,thickness])
            dcylinder(h = realH, d = inDiam - twoThickness, s= l);


        translate([inDiam/2,inDiam/2,-tolerance/2])
        cylinder(h = thickness+tolerance, d = drainOd);
    }
}

module dcylinder(d,h,s){
    intersection(){
        translate([d/2,d/2,0])
        cylinder(h=h,d=d);
        cube([d,d-s,h]);
    }
}