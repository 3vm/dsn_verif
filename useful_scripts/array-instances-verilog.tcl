#!/usr/bin/tclsh

puts "Script to convert separate parallel instances into an array"

set filename [ lindex $argv 0 ]

set fp [ open $filename r]

regexp {(.*?).v} $filename -> filename_wo_dotv

set fpw [ open ${filename_wo_dotv}.array.v w ]
set state "No top module yet"

set dcaps {DCAP0 DCAP1 DCAP2}
foreach dcap $dcaps {
	set cap_cnt($dcap) 0
	set connections($dcap) ""
}

while { [gets $fp line ] != -1 } {
  if { $state == "No top module yet" } {
  	if { [regexp {^\s*module top} $line ] } {
	  	puts "Found top module"
		  set state "In top module"
		}
 		puts $fpw $line
 	} elseif { $state == "In top module" } {
  	if { [regexp {^\s*endmodule} $line ] } {
	  	puts "Found endmodule"
      foreach dcap $dcaps {
      	puts "Count of $dcap is $cap_cnt($dcap)"
      	if { $cap_cnt($dcap)>0} {
      	  set up_index [expr {$cap_cnt($dcap) - 1}]
	        puts $fpw "$dcap i${dcap} \[$up_index:0\] $connections($dcap)"
	      }
      }
   		puts $fpw $line
		} else {
		  set dcap {}
		  set con {}
		  regexp {^\s*(DCAP\d+)\s+\S+\s+(.*)} $line -> dcap con
		  if { $dcap != "" } {
			  incr cap_cnt($dcap)
			  set connections($dcap) $con
			  #puts "Decap $dcap"
		  } else {
			  puts $fpw $line
		  }
    }
  }
}

close $fp
close $fpw

