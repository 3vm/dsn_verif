
foreach iter {single parallel} {
  set dirname synth_${iter}.log
  file mkdir $dirname
  cd $dirname
  catch {
    close_project
  }
  create_project -force prj_${iter}
  add_files ../adder_engine.sv
  set top adder_engine
  if { $iter == "parallel"} {
    add_files ../adder_parallel.sv
    add_files ../../../ehgu/ehgu_config_pkg.sv
    add_files ../../../ehgu/ehgu_basic_pkg.sv
    add_files ../../../ehgu/ehgu_cntr.sv
    add_files ../../../ehgu/ehgu_clkdiv.sv
    set top adder_parallel
  } 

  add_files ../adder_speedtest.sdc
  if { $iter == "parallel"} {
    add_files ../div_clk.sdc
  } 

  set_property top $top [current_fileset]
  set_property generic WIDTH=64 [current_fileset]

  synth_design
  place_design
  route_design
  
  report_utilization > utilization.txt
  report_timing_summary > timing_summary.txt
  report_timing > timing.txt

  cd ..
}
