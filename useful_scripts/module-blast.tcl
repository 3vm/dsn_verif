#!/usr/bin/tclsh

set filename [ lindex $argv 0 ]
set tempoutfile ".tmp_z1asdF3eqwe523"
set modorder "module_order.f"
set outdir "split_files"

file mkdir $outdir
file delete -force $outdir/*

set fp [ open $filename r]
set fpw [ open $outdir/$tempoutfile w ]
set fp_dotf [open $outdir/$modorder w]

set this_module "dollar_unit_scope"
set prev_module $this_module

while { [gets $fp line ] != -1 } {
	if { [regexp {^\s*endmodule} $line ] } {
		puts "Found endmodule, output file with module name"
		puts $fpw $line
		close $fpw
		file rename $outdir/$tempoutfile $outdir/${this_module}.sv
		set fpw [ open $outdir/$tempoutfile w ]
		set prev_module $this_module
		set this_module "dollar_unit_scope"
	} else {
		set mod {}
		regexp {^\s*module\s+(\S+)} $line -> mod
		if { $mod != "" && $this_module == "dollar_unit_scope" } {
			puts "Found module $mod"
			puts $fp_dotf $mod
			set prev_module $this_module
			set this_module $mod
		}
		puts $fpw $line
	}
}

close $fp
close $fpw
close $fp_dotf

file rename -force $tempoutfile $filename

#3vm, start Jan 2020
