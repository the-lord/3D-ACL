/********************************************************
                AnotherCustomLeg
                 LordRaven 2017
                      v0.2
*********************************************************/


/********************************************************

External Module: Bevel
https://github.com/Obijuan/obiscad/tree/master/obiscad

*********************************************************/
use<obiscad\bevel.scad>


/***************************************
                Variables
****************************************/


h = 90;  //height
w = 40;  //width
d = 40;  //depth
t = 4;   //thickness
f = 20;  //flap


// don't touch this values
seg = 2+t;  //so that the cuts are not flush
ctr = true; //centre



/***************************************
                Modules
****************************************/



// don't touch
module leg()
{
    difference()
    {
        cube([w,d,h]);
    
        translate([t,t,t])
            cube([w-2*t,d-2*t,h-t+seg]);
    }
    
}



// don't touch
module xflap(reinforcement=false, m=0)
{
    difference()
    {
        translate([w,0,0])
            cube([f,d-m,t]);

        if (d-m > 19)
        {
            translate([(w+f/2),((d-m)/4),0])
                cylinder(3+seg,3/2,4/2,$fn=100,center=ctr);

            translate([(w+f/2),((3*(d-m))/4),0])
                cylinder(3+seg,3/2,4/2,$fn=100,center=ctr);
        }
        else
        {
            translate([(w+f/2),((d-m)/2),0])
                cylinder(3+seg,3/2,4/2,$fn=100,center=ctr);
        }
    }
        
    if (reinforcement==true)
    {
        // Define the connectors
        ec1 = [ [w, (d-m)/2, t], [0,1,0], 0];
        en1 = [ ec1[0], [1,0,1], 0];
        bconcave_corner_attach(ec1,en1,l=d-m,cr=6,cres=10);
    }
}

// don't touch
module yflap(reinforcement=false, m=0)
{
    difference()
    {
        translate([0,d,0])
            cube([w-m,f,t]);

        if (w-m > 19)
        {
            translate([((w-m)/4),(d+f/2),0])
                cylinder(3+seg,3/2,4/2,$fn=100,center=ctr);

            translate([((3*(w-m))/4),(d+f/2),0])
                cylinder(3+seg,3/2,4/2,$fn=100,center=ctr);
        }
        else
        {
             translate([((w-m)/2),(d+f/2),0])
                cylinder(3+seg,3/2,4/2,$fn=100,center=ctr);
        }
    }
    
    if (reinforcement==true)
    {
        // Define the connectors
        ec2 = [ [(w-m)/2, d, t], [1,0,0], 0];
        en2 = [ ec2[0], [0,1,1], 0];
        bconcave_corner_attach(ec2,en2,l=w-m,cr=6,cres=10);
    }
}



/***************************************
                Main
****************************************/

union()
{

    leg();
    xflap(reinforcement=true,m=2);
    yflap(reinforcement=true,m=2);
   
}

