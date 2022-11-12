
proc print_uniq_timing_paths { paths } {
  lsort -unique $paths
  set paths [ lsort -unique $paths ]
  foreach p $paths {
    puts $p
  }
}