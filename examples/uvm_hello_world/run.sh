~/xilinx_vivado/Vivado/2019.2/bin/xvlog --incr --sv -L uvm --work work -f sim.f
~/xilinx_vivado/Vivado/2019.2/bin/xelab --snapshot work tb
~/xilinx_vivado/Vivado/2019.2/bin/xsim work --runall

