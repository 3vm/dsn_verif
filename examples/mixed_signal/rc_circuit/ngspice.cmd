source rc.cir
tran 0.5u 100u

MEAS TRAN tr TRIG v(out) VAL=0.1 RISE=1 TARG v(out) VAL=0.9 RISE=1 
MEAS TRAN tf TRIG v(out) VAL=0.9 FALL=1 TARG v(out) VAL=0.1 FALL=1
let timconst='tr/ln(9)'
print timconst

plot in out
