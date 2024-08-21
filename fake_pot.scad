realH = 50;
fakeH = 100;
thickness= 3;
diameter = 100;

dcylinder(diameter, fakeH, 10);

module pot(){
    difference(){
    cylinder(h = fakeH, d = diameter);
        
        translate([0,0,thickness])
        cylinder(h = fakeH, d = diameter-thickness*2);
    }
}

module dcylinder(d,h,s){
    intersection(){
        translate([d/2,d/2,0])
        cylinder(h=h,d=d);
        cube([d,d-s,h]);
    }
}