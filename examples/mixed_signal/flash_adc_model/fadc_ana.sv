module fadc_ana (
input real ana_in ,
output logic [ 256-1 : 0 ] dig_raw
 ) ;

real thresholds [ 256-1 : 0 ] ;

initial begin
   foreach ( thresholds [ i ] ) begin
     thresholds [ i ] = i / 256.0 ;
   end
end

always_comb begin
   foreach ( dig_raw [ i ] ) begin
     dig_raw [ i ] = ( ana_in > thresholds [ i ] ) ;
   end
end

  logic vikram;
endmodule
