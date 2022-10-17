enum {S0,S1,S2,S3,S4,S5,S6,S7} state, next;
case (state)
  S0: next = S1;
  S1: next = S4;
  S2: next = S1;
  S3: next = S5;
  S4: next = S3;
  S5: next = S6;
  S6: next = S2;
  default: next = state;
endcase

always_ff @(posedge clk, negedge rstn) 
  if ( !rstn )
    state <= S0;
  else 
    state <= next;
