source rc.cir
tran 0.5u 100u

MEAS TRAN tr TRIG v(out) VAL=-0.8 RISE=2 TARG v(out) VAL=-0.2 RISE=2
MEAS TRAN tf TRIG v(out) VAL=0.8 FALL=2 TARG v(out) VAL=0.2 FALL=2

*Measuring the slow part
MEAS TRAN tr2 TRIG v(out) VAL=-0.08 RISE=3 TARG v(out) VAL=-0.02 RISE=3
MEAS TRAN tf2 TRIG v(out) VAL=0.08 FALL=2 TARG v(out) VAL=0.02 FALL=2

*let timconst='tr/ln(9)'
*print timconst

* AC analysis
*	ac dec 10 100 10000000
*	plot out


plot in out
