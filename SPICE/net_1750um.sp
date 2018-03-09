* net sim

.OPTIONS LIST NODE POST
.OPTION METHOD=GEAR
.OP

VSS VSS 0 DC 0V
VDD VDD VSS DC 1.2V
VI IN 0 pwl( 0 0v 500p 0v 510p 1.2v 5000p 1.2v )

rDis1 IN i1 17.5
cDis1 i1 0 3.375e-14

rDis2 i1 i2 17.5
cDis2 i2 0 3.375e-14

rDis3 i2 i3 17.5
cDis3 i3 0 3.375e-14

rDis4 i3 i4 17.5
cDis4 i4 0 3.375e-14

rDis5 i4 i5 17.5
cDis5 i5 0 3.375e-14

rDis6 i5 i6 17.5
cDis6 i6 0 3.375e-14

rDis7 i6 OUT 17.5
cDis7 OUT 0 3.375e-14

cReceiver OUT 0 5e-15

.measure tran rise_delay trig v(IN) val=0.6 rise=1 targ v(OUT) val=0.6 rise=1

.tran 1p 5000p 

.end
