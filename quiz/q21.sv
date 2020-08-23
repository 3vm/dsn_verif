`define USETYPEDEF
module tb;

`ifdef USETYPEDEF

typedef  int arr2x2_t [2][2] ;

arr2x2_t k;
function arr2x2_t myfn() ;
  foreach (myfn[i,j])
    myfn[i][j] = i*j;
endfunction

`else
int k[2][2];
function int myfn [2][2] ();
  foreach (myfn[i,j])
    myfn[i][j] = i*j;
endfunction

`endif

initial begin
  k = myfn();
  $display("%3d\t%3d\n%3d\t%3d",k[0][0],k[0][1],k[1][0],k[1][1]);
end

endmodule

