module mym2 
( input i0,i1,i2, output out0,out1,out3) ;
generate
  for (genvar gi = 0; gi<4;gi++) begin
    assign out${gi} = i${gi}; //create signal name by concatenating strings
  end
endgenerate
endmodule
