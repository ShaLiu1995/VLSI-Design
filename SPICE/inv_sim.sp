* F04 sim
.include '65nm_bulk.pm'
.include 'invx4.cdl'

.OPTIONS LIST NODE POST
.OPTION METHOD=GEAR
.OP

VSS VSS 0 DC 0V
VDD VDD VSS DC 1.2V
VI IN 0 pwl( 0 1.2v 500p 1.2v 510p 0v 5000p 0v 5010p 1.2v 10000p 1.2v)
cload1 Y1 0 2e-15
cload2 Y2 0 2e-15
cload3 Y3 0 2e-15
cload4 Y4 0 2e-15

* subckt instantiation like the following must start with the character 'x' (or 'X')
Xinv IN OUT VDD VSS INVX4

XFO1 OUT Y1 VDD VSS INVX4
XFO2 OUT Y2 VDD VSS INVX4
XFO3 OUT Y3 VDD VSS INVX4
XFO4 OUT Y4 VDD VSS INVX4

.measure tran rise_delay trig v(IN)  val=0.6  fall=1 targ v(OUT) val=0.6  rise=1
.measure tran fall_delay trig v(IN)  val=0.6  rise=1 targ v(OUT) val=0.6  fall=1
* assume rise (fall) slew = transition time from 0.3 * VDD to 0.7 * VDD (from 0.7 * VDD to 0.3 * VDD)
.measure tran rise_slew  trig v(OUT) val=0.36 rise=1 targ v(OUT) val=0.84 rise=1
.measure tran fall_slew  trig v(OUT) val=0.84 fall=1 targ v(OUT) val=0.36 fall=1

.tran 1p 10000p 

.end
