module fadc_dig (
  input logic [256-1:0] dig_raw,
  output logic [7:0] dig_out
);

always_comb begin
  for(int i=256-1;i>0;i--) begin
    if ( dig_raw[i]) begin
       dig_out = i ;
       break;
    end
  end
end

//or while loop
/*
logic [256-1:0] raw_tmp;
cnt=0;
while (raw_tmp>0) begin
  cnt++;
  raw_tmp >>= 1;
end
dig_out = cnt -1;

or

logic [8:0] sum;
sum=0;
foreach ( dig_raw[i]) begin
 sum += dig_raw[i];
end
sum -= 1;

//or sum of bits -1

endmodule
