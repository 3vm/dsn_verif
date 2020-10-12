~/xilinx_vivado/Vivado/2019.2/bin/xvlog --incr --sv --work work -f sim.f
~/xilinx_vivado/Vivado/2019.2/bin/xelab -mt 4 --snapshot work tb
~/xilinx_vivado/Vivado/2019.2/bin/xsim work --runall

