#!/usr/bin/tcsh
find . -name '*.sv' | xargs cat | grep -e "endmodule" -e "endtask" -e "endfunction" | wc
