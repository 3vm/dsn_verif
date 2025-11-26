module i2c_ep (
inout sda,
input scl,
input clkin,
output logic [7:0] addr,
output logic [7:0] data,
output re
);

localparam SELF_ADDR = 8'h 27; //allow metal programming later





endmodule

