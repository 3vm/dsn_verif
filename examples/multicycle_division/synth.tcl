
foreach iter {1 10} {
  set dirname synth${iter}c.log
  file mkdir $dirname
  cd $dirname
  create_project -force single_cyc
  add_files ../sample_avg.sv 
  add_files ../../../ehgu/ehgu_cntr.sv 
  add_files ../sample_avg.sdc

  if { $iter != 1 } {
    puts $iter
    set_multicycle_path $iter -from sum_reg[*]/Q -to avg_out_reg[*]/D
    set_multicycle_path $iter -from cntr/cnt_reg[*]/* -to avg_out_reg[*]/D
  }

  set_property top sample_avg [current_fileset]
  set_property generic DIV_CYCLES=$iter [current_fileset]
  synth_design
  #report_utilization > utilization.txt
  cd ..
}
