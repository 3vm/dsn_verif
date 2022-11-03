module tb ;

timeunit 1ns ;
timeprecision 1ps ;
parameter STEP=1;

parameter real LT=0.25;
parameter real UT=0.83;

real ramp, ana_in;
bit result;
logic dig_out, dig_out_exp;

initial begin
  ramp = 0.05;
  repeat (2) begin
    while (ramp < 0.95) begin
    #STEP;
      ramp+= 0.001;
    end
    while (ramp > 0.05) begin
      #STEP;
      ramp-= 0.001;
    end
  end

  if ( result )
  $display ( "PASS" ) ;
  else begin
    $display ( "FAIL" ) ;
    $finish ;
  end

  $finish ;
end

assign ana_in = ramp ;

initial begin
  $display("Analog input = %f, Digital output = %b",ana_in,dig_out);
  forever @(dig_out) begin
    $display("Analog input = %f, Digital output = %b",ana_in,dig_out);
  end
end

//schmitt_trigger_inv #(.LT(LT), .UT(UT+0.1)) sinv (.in(ana_in) , .out(dig_out) ) ;
schmitt_trigger_inv #(.LT(LT), .UT(UT)) sinv (.in(ana_in) , .out(dig_out) ) ;

always @(ana_in)
  if (ana_in< LT)
    dig_out_exp = 1 ;
  else if ( ana_in > UT )
    dig_out_exp = 0 ;

initial begin
  result = 1;
  forever @(dig_out_exp) begin
    #0;
    if ( dig_out_exp != dig_out )
      result = 0 ;
  end
end

  logic vikram;
endmodule
