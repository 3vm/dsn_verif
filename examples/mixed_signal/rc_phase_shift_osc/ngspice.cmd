source rc.cir
tran 0.5u 100u

MEAS TRAN tr TRIG v(out) VAL=0.2 RISE=3 TARG v(out) VAL=0.4 RISE=3 
MEAS TRAN tf TRIG v(out) VAL=0.4 FALL=3 TARG v(out) VAL=0.2 FALL=3
*let timconst='tr/ln(9)'
*print timconst

* AC analysis
*	ac dec 10 100 10000000
*	plot out


plot in out
