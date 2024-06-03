include <BOSL2/std.scad>


$fn = 128;



endCapBaseHeight = 2;
endCapOuterScale = 1.1;
endCapFullHeight = 25;



ADiameter = 47.9 * 1.005;

CYOffset = 20 * 1.01;

BYOffset = 12.5 * 1.01;
BDiameter = ((pow((ADiameter / 2), 2) + pow(BYOffset, 2)) / (2 * BYOffset)) * 2;






module innerShape()
{
    fwd(BYOffset - (BYOffset + CYOffset) / 2)
    {
        difference()
        {
            circle(d = ADiameter);

            back(ADiameter / 2)
                rect([ADiameter, ADiameter]);

            fwd(ADiameter / 2 + CYOffset)
                rect([ADiameter, ADiameter]);
        }


        difference()
        {
            fwd(BDiameter / 2 - BYOffset)
                circle(d = BDiameter);
            
            fwd(BDiameter / 2)
                rect([BDiameter, BDiameter]);
        }
    }
}



// test_slice
*linear_extrude(endCapBaseHeight)
    difference()
    {
        scale(endCapOuterScale)
            innerShape();

        innerShape();
    }



difference()
{
    union()
    {
        linear_extrude(height = endCapBaseHeight, scale = endCapOuterScale)
            innerShape();

        up(endCapBaseHeight)
            linear_extrude(endCapFullHeight)
                scale(endCapOuterScale)
                    innerShape();
    }

    up(endCapBaseHeight * 2)
        linear_extrude(endCapFullHeight)
            innerShape();
}

difference()
{
    scale(0.88)
        linear_extrude(endCapFullHeight)
            innerShape();


    linear_extrude(endCapFullHeight)
        scale(0.77)
            innerShape();


    h = (BYOffset + CYOffset) / 1.2;

    xflip_copy()
        translate([ADiameter / 7, -h / 1.82, endCapBaseHeight])
            cube([ADiameter / 6, h, endCapFullHeight]);

}