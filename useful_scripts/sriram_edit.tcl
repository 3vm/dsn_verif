#!/usr/bin/tclsh
#editing format in honor of Software Engineer Ram
#

set filename [ lindex $argv 0 ]
set tempoutfile ".tmp_z13asxr93eqwe523"

puts "Formatting $filename"

set fp [ open $filename r]

set fpo [ open $tempoutfile w ]

set line {}
set prev_line $line

set ind_lvl 0

while { [gets $fp line ] != -1 } {
	regsub -all {\s+} $line { } line
	regsub -all {=} $line { = } line
	regsub -all {=\s*=\s*=} $line {===} line
	regsub -all {=\s*=} $line {==} line
	regsub -all {!\s*=} $line {!=} line
	regsub -all {~\s*=} $line {~=} line
	regsub -all {<} $line { < } line
	regsub -all {<\s+<} $line {<<} line
	regsub -all {<\s+=} $line {<=} line
	regsub -all {>\s+=} $line {>=} line
	regsub -all {>} $line { > } line
	regsub -all {>\s+>} $line {>>} line
	regsub -all {!==} $line { !== } line
	regsub -all {,} $line { , } line
	regsub -all {:} $line { : } line
	regsub -all {:\s+:} $line {::} line
	regsub -all {\+} $line { + } line
	regsub -all {\+\s+\+} $line {++} line
	regsub -all {\+\s+\=} $line {+=} line

	regsub -all {\*} $line { * } line
	regsub -all {\*\s*\*} $line {**} line
	regsub -all {\*\s*\=} $line {*=} line

	regsub -all {/} $line { / } line
	regsub -all {/\s*/} $line {//} line
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

file rename -force $tempoutfile $filename

#3vm, start Jan 2020