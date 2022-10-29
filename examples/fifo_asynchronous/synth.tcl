  set dirname syn
  file mkdir $dirname
  cd $dirname
  catch {
    close_project
  }
  create_project -force try
add_files ../../../ehgu/ehgu_config_pkg.sv
add_files ../../../ehgu/ehgu_basic_pkg.sv
add_files ../../../ehgu/ehgu_clkdiv_fractional.sv
add_files ../../../ehgu/ehgu_cntr.sv
add_files ../../../ehgu/ehgu_dly.sv
add_files ../../../ehgu/ehgu_edges.sv
add_files ../../../ehgu/ehgu_fedge.sv
add_files ../../../ehgu/ehgu_redge.sv
add_files ../../../ehgu/ehgu_rst_sync.sv
add_files ../../../ehgu/ehgu_ram_dual_port.sv
add_files ../../../ehgu/ehgu_synqzx.sv
add_files ../../../ehgu/ehgu_fifo_mem.sv
add_files ../../../ehgu/ehgu_fifo_logic.sv
add_files ../../../ehgu/ehgu_fifo.sv

#add_files ../constraints.sdc

  set_property top ehgu_fifo [current_fileset]

  synth_design
#  place_design
#  route_design
  
  report_utilization > utilization.txt
  report_timing_summary > timing_summary.txt
  report_timing > timing.txt

#  close_project
  cd ..
