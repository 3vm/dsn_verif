set VIVADO_HOME=/tools/Xilinx/2025.1/Vivado/bin/
$VIVADO_HOME/xvlog --incr --sv --work work -f sim.f
$VIVADO_HOME/xelab -mt 4 --snapshot work tb
$VIVADO_HOME/xsim work --runall -sv_seed random

