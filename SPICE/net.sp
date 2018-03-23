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

rDis3 i2 OUT 17.5
cDis3 OUT 0 3.375e-14

cReceiver OUT 0 5e-15

.measure tran rise_delay trig v(IN) val=0.6 rise=1 targ v(OUT) val=0.6 rise=1

.tran 1p 5000p 

.end