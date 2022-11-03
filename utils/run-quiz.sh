~/xilinx/Vivado/2022.1/bin/xvlog --sv --work work $1 $2
~/xilinx/Vivado/2022.1/bin/xelab -mt 4 --snapshot work tb
~/xilinx/Vivado/2022.1/bin/xsim work --runall -sv_seed random

