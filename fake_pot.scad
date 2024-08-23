realH = 50;
fakeH = 100;
thickness= 3;
l=2;
diameter = 100;

drainId = 5;
tolerance = 0.4;

nHoles = 6;

drainOd = drainId + thickness * 4 + tolerance * 2;


$fn=40;

twoThickness = thickness * 2;
inDiam = diameter - twoThickness;

difference(){
    translate([0,0,0])
    {
        pot();

        translate([thickness,thickness,-realH+fakeH])
        inPot();
    }

    //slice for previewing
    if($preview){
        translate([0,0,-0.5])
        cube([diameter*2,diameter/2,fakeH+1]);
    }
}

tunnel();

module pot(){
    difference(){
        translate([0,0,0]){
            dcylinder(h = fakeH, d = diameter,s = l);
            translate([diameter/2,diameter/2,0])
            {
                tunnel();
            }
        }

        translate([thickness,thickness,thickness])
            dcylinder(h = fakeH, d = inDiam, s= l);

        //draining holes
        translate([diameter/2,diameter/2,-tolerance/2]){
            cylinder(h = thickness+tolerance, d = drainId+thickness*2);


            for (i=[0:nHoles-1]){
                rotate([0,0,i*360/nHoles])
                translate([(inDiam-tolerance*2-thickness*2)/3,0,0])
                cylinder(h = thickness+tolerance, d = drainId+thickness*2);
            }
        }

        translate([diameter/2,diameter/2,0])
        {
            tunnel_drill();
        }
    }

    translate([diameter/2,diameter/2,0]){
        drain_downpipe();

        for (i=[0:nHoles-1]){
            rotate([0,0,i*360/nHoles])
                translate([(inDiam-tolerance*2-thickness*2)/3,0,0])
            drain_downpipe();
        }
    }
}

module drain_downpipe(){
    //small pipe
    translate([0,0,fakeH-realH])
    difference(){
        cylinder(d=drainOd - tolerance, h = thickness);
        cylinder(d=drainId+thickness * 2 + tolerance , h = thickness);
    }

    //V
    translate([0,0,fakeH-realH - (drainOd - tolerance-thickness*2 -drainId)/2])
    difference() {
        cylinder(d1=drainId+thickness*2,d2= drainOd - tolerance, h = (drainOd - tolerance-thickness*2 -drainId)/2);
        cylinder(d1=drainId,d2= drainOd - tolerance-thickness*2, h = (drainOd - tolerance-thickness*2 -drainId)/2);

    }
    
    //large pipe
    difference(){
        cylinder(d=drainId+thickness*2, h = fakeH-realH - (drainOd - tolerance-thickness*2 -drainId)/2);
        cylinder(d=drainId , h = fakeH-realH - (drainOd - tolerance-thickness*2 -drainId)/2);
    }
}

module inPot(){
    //pot with hole
    difference(){
        translate([tolerance,tolerance,0])
        dcylinder(h = realH, d = inDiam-tolerance*2,s = l);

        translate([thickness+tolerance,thickness+tolerance,thickness])
            dcylinder(h = realH, d = inDiam - twoThickness -tolerance*2, s= l);

        //drain hole
        translate([inDiam/2,inDiam/2,-tolerance/2]){
            cylinder(h = thickness+tolerance*2, d = drainOd);

            
            for (i=[0:nHoles-1]){
                rotate([0,0,i*360/nHoles])
                translate([(inDiam-tolerance*2-thickness*2)/3,0,0])
                cylinder(h = thickness+tolerance*2, d = drainOd);
            }
        }
        
    }

    translate([inDiam/2,inDiam/2,0]){
        drain_connector();
    
        for (i=[0:nHoles-1]){
            rotate([0,0,i*360/nHoles])
            translate([(inDiam-tolerance*2-thickness*2)/3,0,0])
            drain_connector();
        }
    }
}

module drain_connector(){
    //V
    color("red")
    translate([0,0,thickness])
    difference() {
        cylinder(d1=drainId + thickness*2, d2 = drainOd+ thickness*2, h = (drainOd -drainId)/2);
        cylinder(d1=drainId, d2= drainOd, h= (drainOd -drainId)/2);
    }

    //Drain outer neck
    difference(){
        cylinder(d=drainOd+thickness*2, h = (drainOd -drainId)/2 + thickness);
        cylinder(d=drainOd, h = (drainOd -drainId)/2 + thickness);
    }

    //Drain inner neck
    difference() {
        cylinder(d= drainId + thickness*2 , h = thickness);
        cylinder(d= drainId, h=thickness);
    }
}

module dcylinder(d,h,s){
    intersection(){
        translate([d/2,d/2,0])
        cylinder(h=h,d=d);
        cube([d,d-s,h]);
    }
}

module tunnel(){
    rotate([-90, 0,0]) {
        difference(){
            cylinder(d=thickness*3, h=diameter, $fn=4, center=true);
            cylinder(d=thickness, h=diameter, $fn=4, center=true);
            translate([0,thickness*0.75 ,0])
            cube([thickness*3, thickness*1.5, diameter], center=true);
        }
    }
}

module tunnel_drill(){
    rotate([-90, 0,0]) {
        cylinder(d=thickness*3, h=diameter, $fn=4, center=true);
    }
}