module thee_pfd
(
input logic clk0,
input logic clk1,
output logic up,
output logic down
);

logic q0,q1;
logic rst_pfd;

always_ff @(posedge clk0 or posedge rst_pfd) begin 
  if(rst_pfd) begin
    q0 <= 0;
  end else begin
    q0 <= 1'b1;
  end
end

always_ff @(posedge clk1 or posedge rst_pfd) begin 
  if(rst_pfd) begin
    q1 <= 0;
  end else begin
    q1 <= 1'b1;
  end
end

assign rst_pfd = q0 & q1;

assign {up,down} = {q0,q1};

endmodule
