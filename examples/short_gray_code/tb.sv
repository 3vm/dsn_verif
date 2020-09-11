
program tb ;
logic result ;
import thee_utils_pkg::print_test_result;
import thee_utils_pkg::create_test_result_file;
localparam MAX_CODE_LEN = 1024;
typedef logic [$clog2(MAX_CODE_LEN)-1:0] code_t;

class short_gray;
  int len;
  rand code_t gcode [MAX_CODE_LEN];
  function void set_len (input int l);
    len=l;
  endfunction
  //constraint no_repeat { unique {gcode[0:MAX_CODE_LEN-1]}; };
  constraint no_repeat { 
    for(int i=0;i<len;i++) 
      for(int j=0;j<len;j++) 
        if(i!=j)
          gcode[i]!=gcode[j];
  };


  function void show ();
    $display("Gray code that was created");
    for (int i = 0; i < len; i++) begin
      $write("%b ",gcode[i]);
    end
  endfunction : show
endclass : short_gray

initial begin
   automatic short_gray sg=new();
   sg.set_len(6);
   result = 1 ;

  if (sg.randomize()) begin
    $display("Randomize passed, Gray code created");
    result &= 1;
  end else begin
    $display("Randomize failed, Gray code not created");
    result &= 0;
  end
  sg.show();
  print_test_result(result);
  create_test_result_file(result);
  $finish ;
end

endprogram
