~/xilinx_vivado/Vivado/2019.2/bin/xvlog --sv --work work $1
~/xilinx_vivado/Vivado/2019.2/bin/xelab -mt 4 --snapshot work tb
~/xilinx_vivado/Vivado/2019.2/bin/xsim work --runall -sv_seed random

