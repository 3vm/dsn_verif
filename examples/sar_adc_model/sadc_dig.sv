module sadc_dig (
  input logic clk,
  input logic rstn,
  input logic cmp_out,
  input logic start,
  
  output logic [7:0] dig_out,
  output logic eoc
);

logic [$clog2(8)-1:0] index, cnt;
logic sync_clr;
logic [7:0] code;

logic conversion_running;

assign index = 8-1-cnt;

ehgu_cntr cntr (
.clk,
.rstn,
.sync_clr,
.en(conversion_running),
.cnt
);

assign sync_clr = start;

always_comb begin
  code = dig_out;
  if ( start ) begin
    code = (2**(8-1));
  end else if ( index == 8-1) begin
    code[index]=1'b1;
  end else if ( index inside {[0:8-2]}) begin
    if ( cmp_out == 1'b1 ) begin
      code[index+1]=1'b1;
      code[index] = 1'b1;
    end else begin
      code[index+1]=1'b0;
      code[index] = 1'b1;
    end
  end
end

always_ff @(posedge clk, negedge rstn) begin
  if ( !rstn) begin
    conversion_running <=0;
    dig_out <= 0;
    eoc <= 0;
  end else begin
    conversion_running <=start ? 1 : (cnt==8-1) ? 0 : conversion_running;
    dig_out <= code;
    eoc <= cnt==8-1;
  end
end 

endmodule
