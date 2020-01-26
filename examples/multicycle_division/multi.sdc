set_multicycle_path 10 -from sum_reg[*]/C -to avg_out_reg[*]/D -setup
set_multicycle_path 9 -from sum_reg[*]/C -to avg_out_reg[*]/D -hold

set_multicycle_path 10 -from cntr/cnt_reg[*]/C -to avg_out_reg[*]/D -setup
set_multicycle_path 9 -from cntr/cnt_reg[*]/C -to avg_out_reg[*]/D -hold
 