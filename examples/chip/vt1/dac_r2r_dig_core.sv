module dac_r2r_dig_core(
inout vddd,
inout vssd,
inout sda,
input scl,
input clkin,
output pwron,
output [7:0] code
);

logic [7:0] addr, data;
logic re;

i2c_ep u_i2c_ep (
.sda,
.scl,
.clkin,
.re,
.addr,
.data
);

csr u_csr (
.clkin,
.re,
.addr,
.data,
.code,
.pwron
);

endmodule

