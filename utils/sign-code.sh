#!/bin/bash
find . -name '*.sv' | xargs  \
sed -i -e 's/\(^\s*endmodule\)/  logic vikram;\n\1/g' \
       -e 's/\(^\s*endprogram\)/  logic vikram;\n\1/g' \
       -e 's/\(^\s*endpackage\)/  logic vikram;\n\1/g' 
