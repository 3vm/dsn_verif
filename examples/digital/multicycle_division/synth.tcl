
foreach iter {1 10} {
  set dirname synth${iter}c.log
  file mkdir $dirname
  cd $dirname
  catch {
    close_project
  }
  create_project -force cycle_test${iter}
  add_files ../sample_avg.sv 
  add_files ../../../ehgu/ehgu_cntr.sv 
  add_files ../sample_avg.sdc

  if { $iter != 1 } {
    add_files ../multi.sdc
  }

  set_property top sample_avg [current_fileset]
  set_property generic DIV_CYCLES=$iter [current_fileset]

  synth_design
  place_design
  route_design
  
  report_utilization > utilization.txt
  report_timing_summary > timing_summary.txt
  report_timing > timing.txt

#  close_project
  cd ..
}
