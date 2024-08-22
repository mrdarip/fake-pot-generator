realH = 50;
fakeH = 100;
thickness= 3;
l=2;
diameter = 100;
drainOd = 15;
drainId = 5;
tolerance = 0.4;

$fn=100;

twoThickness = thickness * 2;
inDiam = diameter - twoThickness;

difference(){
    pot();

    //slice for viewing
    translate([0,0,-0.5])
    cube([diameter*2,diameter/2,fakeH+1]);
}

difference(){
    translate([thickness,thickness,-realH+fakeH])
    inPot();

    //slice for viewing
    translate([0,0,-0.5])
    cube([diameter*2,diameter/2,fakeH+1]);
}


module pot(){
    difference(){
        dcylinder(h = fakeH, d = diameter,s = l);
        
        translate([thickness,thickness,thickness])
            dcylinder(h = fakeH, d = inDiam, s= l);

            //drain hole
        translate([diameter/2,diameter/2,-tolerance/2])
            cylinder(h = thickness+tolerance, d = drainOd-thickness);
    }

    //Drain neck
    translate([diameter/2,diameter/2,0])
    difference(){
        cylinder(d=drainOd-tolerance, h = fakeH-realH);
        cylinder(d=drainId+thickness * 2 + tolerance, h = fakeH-realH);
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
            cylinder(d1=drainId + thickness*2, d2 = drainOd+ thickness*2, h = drainOd -drainId);
            cylinder(d1=drainId, d2= drainOd, h= drainOd -drainId);
        }

        //Drain neck
        translate([inDiam/2,inDiam/2,0])
        difference(){
            cylinder(d=drainOd+thickness*2, h = drainOd -drainId);
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