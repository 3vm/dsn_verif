set design_top sin_cos_iq_gen
set design_files "
$EHGU_HOME/ehgu/ehgu_config_pkg.sv
$EHGU_HOME/ehgu/ehgu_basic_pkg.sv
$EHGU_HOME/ehgu/ehgu_clkdiv_fractional.sv
$EHGU_HOME/ehgu/ehgu_cntr.sv
$EHGU_HOME/ehgu/ehgu_dly.sv
$EHGU_HOME/ehgu/ehgu_edges.sv
$EHGU_HOME/ehgu/ehgu_fedge.sv
$EHGU_HOME/ehgu/ehgu_redge.sv
$EHGU_HOME/ehgu/ehgu_rst_sync.sv

$EHGU_HOME/thee/thee_mathsci_consts_pkg.sv
$EHGU_HOME/thee/thee_utils_pkg.sv
../sin_cos_iq_gen.sv
"

set part_num "xc7k160tlfbv676-2L"
