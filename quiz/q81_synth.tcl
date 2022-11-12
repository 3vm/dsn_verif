set EHGU_HOME $env(EHGU_HOME)

set design_top weird_design
set design_files "
$EHGU_HOME/quiz/q81.sv 
$EHGU_HOME/quiz/q81_constraints.sdc
"

set dirname syn
#set curdir [ basename [ pwd ]]

# Change to syn dir if not already in syn dir
#if { $curdir != $dirname } {
  file mkdir $dirname
  cd $dirname
#}

catch {
  close_project
}

create_project -force try
foreach f $design_files {
  add_files $f
}
#add_files ../constraints.sdc

set_property top $design_top [current_fileset]
  synth_design
#  place_design
#  route_design
  
report_utilization > utilization.txt
report_timing_summary > timing_summary.txt
report_timing > timing.txt

source $EHGU_HOME/utils/vivado/proc_print_uniq_timing_paths.tcl

puts "Rise to fall"
print_uniq_timing_paths [ get_timing_paths -rise_from clk -fall_to clk -max_paths 1000  -slack_greater_than -10000 -nworst 1000 ]

puts "Fall to rise"
print_uniq_timing_paths [ get_timing_paths -fall_from clk -rise_to clk -max_paths 1000  -slack_greater_than -10000 -nworst 1000 ]
#  close_project
cd ..
