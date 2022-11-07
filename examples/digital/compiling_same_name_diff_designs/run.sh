#!/usr/bin/tcsh
source $EHGU_HOME/utils/ehgu.cshrc

$XILINX_HOME/bin/xvlog --incr  --work pkg4b --sv -f 4b.f
$XILINX_HOME/bin/xvlog --incr  --work pkg8b --sv -f 8b.f

$XILINX_HOME/bin/xvlog --incr  -L pkg4b --work add4b --sv add_saturate_4b.sv
$XILINX_HOME/bin/xvlog --incr  -L pkg8b --work add8b --sv add_saturate_8b.sv

$XILINX_HOME/bin/xvlog --incr  -L add4b -L add8b --work work --sv tb.sv

$XILINX_HOME/bin/xelab add4b.add_saturate_4b
$XILINX_HOME/bin/xelab add8b.add_saturate_8b
$XILINX_HOME/bin/xelab -L add4b -L add8b work.tb

$XILINX_HOME/bin/xsim work.tb --runall 
