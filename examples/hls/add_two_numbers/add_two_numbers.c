
int add_two_numbers ( int a, int b) {
#pragma HLS interface ap_ctrl_none port=return
	return (a+b);
}
