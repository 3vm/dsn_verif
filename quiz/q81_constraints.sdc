create_clock -period 1 clk
set_false_path -from "mode e f rstn"
set_false_path -to "g h"
set_case_analysis 1 mode