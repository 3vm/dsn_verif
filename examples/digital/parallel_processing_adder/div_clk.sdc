create_generated_clock -name slowclk -divide_by 2 \
-source [get_ports clk] -add -master_clock clk  \
[get_pins clkdiv/clkout_reg/Q]

#THIS CONSTRAINT IS INVALID, 
#USED HERE ONLY TO AVOID THE INTERCLOCK PATH WITH LARGE SKEW TO BE PRINTED
#USE CORRECT SYNTHESIS SETTINGS TO REDUCE THE SKEW BETWEEN SOURCE AND GENERATED CLOCKS
set_clock_groups -asynchronous -group [get_clocks clk] -group [get_clocks slowclk]
