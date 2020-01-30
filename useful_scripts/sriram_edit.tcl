#!/usr/bin/tclsh
#editing format in honor of Software Engineer Ram
#

set filename [ lindex $argv 0 ]

puts "Formatting $filename"

set fp [ open $filename r]

set line {}
set prev_line $line

set ind_lvl 0

while { [gets $fp line ] != -1 } {
	regsub -all {===} $line { === } line
	regsub -all {!==} $line { !== } line
	regsub -all {,} $line { , } line
	regsub -all {:} $line { : } line
	regsub -all {: :} $line {::} line
	regsub -all {\+} $line { + } line
	regsub -all {\+ \+} $line {++} line
	regsub -all {\*\*} $line { ** } line

	regsub -all {\[} $line { [ } line
	regsub -all {\]} $line { ] } line
	regsub -all {\(} $line { ( } line
	regsub -all {\)} $line { ) } line
	regsub -all {;} $line { ; } line
	regsub -all {[ ]+} $line { } line
	regsub -all {\t} $line {  } line
	regsub -all {\s+$} $line {} line
	puts $line
}

close $fp

#3vm, start Jan 2020