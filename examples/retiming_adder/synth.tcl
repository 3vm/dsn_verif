
foreach iter {pipd rtmd} {
  set dirname synth_${iter}.log
  file mkdir $dirname
  cd $dirname
  catch {
    close_project
  }
  create_project -force prj_${iter}
  add_files ../adder_${iter}.sv 
  add_files ../adder_speedtest.sdc

  set_property top adder_${iter} [current_fileset]
  set_property generic WIDTH=64 [current_fileset]

  synth_design
  place_design
  route_design
  
  report_utilization > utilization.txt
  report_timing_summary > timing_summary.txt
  report_timing > timing.txt

#  close_project
  cd ..
}
