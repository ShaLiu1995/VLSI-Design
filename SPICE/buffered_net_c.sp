* buffered net sim
.include '65nm_bulk.pm'
.include 'invx4.cdl'
.include 'invx32.cdl'

.OPTIONS LIST NODE POST
.OPTION METHOD=GEAR
.OP

VSS VSS 0 DC 0V
VDD VDD VSS DC 1.2V
VI IN 0 pwl( 0 0v 500p 0v 510p 1.2v 3000p 1.2v 3010p 0v 5000p 0v )

.subckt interconnect_segment A B
rDis1 A i1 17.5
cDis1 i1 0 3.375e-14
rDis2 i1 B 17.5
cDis2 B 0 3.375e-14
.ends

* subckt instantiations must start with the character 'x'
* do not modify the following two lines
xInvA IN pInt1 VDD VSS INVX32
xInvB pInt1 p0 VDD VSS INVX32

xSeg1 p0 p1 interconnect_segment


xSeg2 p1 p2 interconnect_segment

xInv2 p2 p3 VDD VSS INVX32


xSeg3 p3 OUT interconnect_segment

cReceiver OUT 0 5e-15

.measure tran rise_delay trig v(p0) val=0.6 rise=1 targ v(OUT) val=0.6 rise=1
.measure tran rise_slew  trig v(OUT) val=0.12 rise=1 targ v(OUT) val=1.08 rise=1
.measure tran fall_slew  trig v(OUT) val=1.08 fall=1 targ v(OUT) val=0.12 fall=1

* power estimation (for interconnect length of 2.5mm)
.measure tran iavg avg i(VDD) from 500p to 650p 
* power estimation (for interconnect length of 9mm)
*.measure tran iavg avg i(VDD) from 500p to 1000p 
.measure power param='-1.0*iavg*1.2'

.tran 1p 5000p 

.end
