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
		if { [regexp {^\s*end\s+.*?\s+begin$} $line] } {
			incr ind_lvl -1
			set delayed_incr_ind 1
		} elseif { [regexp {begin$} $line] } {
			set delayed_incr_ind 1
		} elseif { [regexp {^\s*end\s*} $line] } {
			incr ind_lvl -1
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

#3vm, start Jan 2020
