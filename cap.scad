include <BOSL2/std.scad>


$fn = 128;


ADiameter = 47.9 * 1.005;

CYOffset = 20 * 1.01;

BYOffset = 12.5 * 1.005;
BDiameter = ((pow((ADiameter / 2), 2) + pow(BYOffset, 2)) / (2 * BYOffset)) * 2;


endCapBaseHeight = 2;
endCapOuterScale = 1.1;
endCapFullHeight = 25;



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
!linear_extrude(endCapBaseHeight)
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