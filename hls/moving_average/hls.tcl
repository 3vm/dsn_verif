#set dsn_src "
open_project moving_average
set_top moving_average
add_files moving_average.c
add_files -tb main.c
open_solution "solution1"
set_part {xc7a75ti-ftg256-1L}
create_clock -period 10 -name default
config_sdx -optimization_level none -target none
config_export -vivado_optimization_level 2
set_clock_uncertainty 12.5%
source ./directives.tcl
#csim_design
csynth_design
#cosim_design
#export_design -format ip_catalog

