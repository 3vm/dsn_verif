# Variables, input
set ref 100e6
set req_out 120e6

set vco_min 25e6
set vco_max 900e6

set N_MAX 16
set M_MAX 64

# Calculation
set vco_f 0
set best_error 1e20

for { set N 1} { $N < $N_MAX } { incr N } {
  for { set M 1} { $M < $M_MAX } { incr M } {
    set vco_f [expr $M * $ref / $N]  
    if { ($vco_f < $vco_max ) && ($vco_f > $vco_min)} {
      set error [expr {abs($req_out - $vco_f)}]
      if { $error < $best_error} {
        set best_error $error
        set freq_formatted [format "%1.4e" $vco_f]
        set err_formatted [format "%1.4e" $error]
        puts "PLL N=$N M=$M gives $freq_formatted Hz with deviation $err_formatted Hz"
      }
    }
  }
}

#3vm