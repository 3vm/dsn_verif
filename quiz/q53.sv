module tb;
 logic rst;
 logic [1:0] dat;
 
 port_con i0 (.b[0](rst), .b[1:0](dat));
 port_con i1 (.b({rst,dat}));
endmodule

module port_con ( input [2:0] b);
endmodule
