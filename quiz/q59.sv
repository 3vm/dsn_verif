module tb;

initial $display ("M = %b , N = %b , P = %b", 'b1_1_0_1, 'b1_1001, 3'b100 );
//initial $display ("M = %b , N = %b , P = %b", 'b_1_1_0_1, 'b1_1001, 3'b100 ); //underscore at the beginning of a number is illegal

endmodule