#!/usr/bin/tcsh
find . -name '*.sv' | xargs cat | grep -e "endmodule" -e "endprogram" -e "endtask" -e "endfunction" | wc
