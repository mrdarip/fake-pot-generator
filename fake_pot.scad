realH = 50;
fakeH = 100;
thickness= 3;
l=2;
diameter = 100;
drainOd = 15;
drainId = 5;
tolerance = 0.1;

$fn=100;

twoThickness = thickness * 2;
inDiam = diameter - twoThickness;

difference(){
inPot();

//slice for viewing
        cube([inDiam,inDiam/2,realH]);
}

module pot(){
    difference(){
        dcylinder(h = fakeH, d = diameter,s = l);
        
        translate([thickness,thickness,thickness])
            dcylinder(h = fakeH, d = inDiam, s= l);
    }
}

module inPot(){

    //pot with hole
    difference(){
        dcylinder(h = realH, d = inDiam-tolerance,s = l);

        translate([thickness,thickness,thickness])
            dcylinder(h = realH, d = inDiam - twoThickness, s= l);


        //drain hole
        translate([inDiam/2,inDiam/2,-tolerance/2])
            cylinder(h = thickness+tolerance, d = drainOd);
    }


    //drain connector
        //V
        color("red")
        translate([inDiam/2,inDiam/2,0])
        difference() {
            cylinder(d1=drainId + thickness, d2 = drainOd+ thickness, h = drainOd -drainId);
            cylinder(d1=drainId, d2= drainOd, h= drainOd -drainId);
        }

        //Drain neck
        translate([inDiam/2,inDiam/2,0])
        difference(){
            cylinder(d=drainOd+thickness, h = drainOd -drainId);
            cylinder(d=drainOd, h = drainOd -drainId);
        }

    
}

module dcylinder(d,h,s){
    intersection(){
        translate([d/2,d/2,0])
        cylinder(h=h,d=d);
        cube([d,d-s,h]);
    }
}