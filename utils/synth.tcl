set EHGU_HOME $env(EHGU_HOME)
source synth.cfg.tcl

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

#  close_project
cd ..
