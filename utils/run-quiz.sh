$VIVADO_HOME/xvlog --sv --work work $1 $2
$VIVADO_HOME/xelab -mt 4 --snapshot work tb
$VIVADO_HOME/xsim work --runall -sv_seed random

