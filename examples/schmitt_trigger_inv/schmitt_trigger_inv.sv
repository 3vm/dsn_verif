module schmitt_trigger_inv 
#(
parameter real LT=0.2,
parameter real UT=0.8
)
(
input real in ,
output logic out
 ) ;

bit state;
initial state = $urandom_range(1);

always @(*)
  if ( state == 0  && in > UT )
    state = 1;
  else if ( state == 1  && in < LT )
    state = 0;

assign out = ~state;

endmodule
