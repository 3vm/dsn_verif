read the library, design and timing constraints file into STA tool
remove false paths,  remove asynchronous clock groups
set allck [ all_clocks ] ; # get all clocks in the design
#open a file for dumping results
set fptr [ open “STA_CDC_report.txt” “w” ]
foreach_in_collection clk1 $allck { 
	set clk1_name [ get_attribute $clk1 fullname ]
	foreach_in_collection clk2 $allck { 
		set clk2_name [ get_attribute $clk2 fullname ]
		#for every pair of different clocks in the design
		if { $clk1 != $clk2 } {
			#these are clock crossing paths
			set tpath [ get_timing_paths -from $clk1 -to clk2 ]
			#dump start and end points into a file
			set sp [ get_attribute [ get_attribute $tpath startpoint ] fullname ]
			set ep [ get_attribute [ get_attribute $tpath endpoint ] fullname ]
			puts $fptr “Path exists $clk1_name - $clk2_name : from $sp to $ep”
		}
	}
}