* buffered net sim
.include '65nm_bulk.pm'
.include 'invx16.cdl'
.temp -30

.OPTIONS LIST NODE POST
.OPTION METHOD=GEAR
.OP

VSS VSS 0 DC 0V
VDD VDD VSS DC 1.4V
VI IN 0 pwl( 0 0v 500p 0v 510p 1.4v 5000p 1.4v )

.subckt interconnect_segment A B
rDis1 A i1 17.5
cDis1 i1 0 3.375e-14
rDis2 i1 i2 17.5
cDis2 i2 0 3.375e-14
rDis3 i2 i3 17.5
cDis3 i3 0 3.375e-14
rDis4 i3 B 17.5
cDis4 B 0 3.375e-14
.ends

* subckt instantiations must start with the character 'x'
xInv1 IN p1 VDD VSS INVX16

xSeg2 p1 OUT interconnect_segment

cReceiver OUT 0 5e-15

.measure tran gate_delay trig v(IN) val=0.6 rise=1 targ v(p1)  val=0.6 fall=1
.measure tran wire_delay trig v(p1) val=0.6 fall=1 targ v(OUT) val=0.6 fall=1

.tran 1p 5000p 

.end
