#!/usr/bin/tclsh
#editing format in honor of Software Engineer Sriram
#

proc format_one_file { fl } {

	puts "Formatting $fl"
	set tempoutfile ".tmp_z13asxr93eqwe523"

	set fp [ open $fl r]

	set fpo [ open $tempoutfile w ]

	set line {}
	set prev_line $line

	set ind_lvl 0

	while { [gets $fp line ] != -1 } {
		regsub -all {\s+} $line { } line
		regsub -all {=} $line { = } line
		regsub -all {>} $line { > } line
		regsub -all {=\s*=\s*=} $line {===} line
		regsub -all {=\s*=} $line {==} line
		regsub -all {!\s*=} $line {!=} line
		regsub -all {~\s*=} $line {~=} line
		regsub -all {\^\s*=} $line {^=} line
		regsub -all {<} $line { < } line
		regsub -all {<\s+<} $line {<<} line
		regsub -all {<\s*=} $line {<=} line
		regsub -all {>\s*=} $line {>=} line
		regsub -all {>\s+>} $line {>>} line
		regsub -all {!==} $line { !== } line
		regsub -all {,} $line { , } line
		regsub -all {:} $line { : } line
		regsub -all {:\s+:} $line {::} line
		regsub -all {\+} $line { + } line
		regsub -all {\+\s+\+} $line {++} line
		regsub -all {\+\s+\=} $line {+=} line
		regsub -all {\-\s+\=} $line {-=} line

		regsub -all {\*} $line { * } line
		regsub -all {\*\s*\*} $line {**} line
		regsub -all {\*\s*\=} $line {*=} line
		regsub -all {&\s*=} $line {\&=} line

		regsub -all {/} $line { / } line
		regsub -all {/\s*/} $line {//} line
		regsub -all {\/\s*\*} $line {/*} line
		regsub -all {\*\s*\/} $line {*/} line
		regsub -all {/\s*=} $line {/=} line
		regsub -all {/\s*/} $line { // } line

		regsub -all {\[} $line { [ } line
		regsub -all {\]} $line { ] } line
		regsub -all {\(} $line { ( } line
		regsub -all {\)} $line { ) } line
		regsub -all {\{} $line "\{ " line
		regsub -all {\}} $line " \}" line
		regsub -all {;} $line { ; } line
		regsub -all {[ ]+} $line { } line
		regsub -all {\t} $line {  } line
		regsub -all {\s+$} $line {} line
		set delayed_incr_ind 0
		puts $line; puts "$ind_lvl $delayed_incr_ind"
		if { [regexp {^\s*end\s+.*?\s+begin$} $line] || [regexp {^\s*task\s+} $line] || [regexp {^\s*function\s+} $line] } {
			if { $ind_lvl >=1} { incr ind_lvl -1 } ;#checkme more elegant bug fix needed, spurious end begin should not be allowed to happen
			set delayed_incr_ind 1
		} elseif { [regexp {begin$} $line] } {
			set delayed_incr_ind 1
		} elseif { [regexp {^\s*end\s*} $line] || [regexp {^\s*endtask\s*} $line] || [regexp {^\s*endfunction\s*} $line] } {
			if { $ind_lvl >=1} { incr ind_lvl -1 } ;#checkme
		}
		for {set i 0} {$i<$ind_lvl} {incr i} {
			puts -nonewline $fpo "  "
		}
		puts $fpo $line
		if { $delayed_incr_ind } { 
			incr ind_lvl 
		}
	}

	close $fp
	close $fpo

	file rename -force $tempoutfile $fl
}

set files [ lindex $argv 0 ]

if { $files == "" } {
  foreach fl [ glob *.sv ] {
    format_one_file $fl
  }
} else {
  format_one_file $files
}

set author Vikram
