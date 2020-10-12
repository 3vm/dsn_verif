program tb;
// Variables, input
real ref_freq=100e6;
real req_out=120e6;
real vco_min=25e5;
real vco_max=900e6;
int N_MAX=32768;
int M_MAX=8192;
int cores=4;
real vco_f=0;
real best_vco_f=0;
int best_N=0;
int best_M=0;
real best_error=1e20;
real error;
// Calculation
initial begin
vco_f=0;
best_vco_f=0;
best_N=0;
best_M=0;
best_error=1e20;
cores=1;
for (int N=1;N<=N_MAX;N=N+cores) begin
//	N_local = N + rank;
	for (int M=1; M<M_MAX;M++) begin
		vco_f = M * ref_freq / N ;// N_local;
		if ( (vco_f < vco_max ) && (vco_f > vco_min)) begin
			error=$sqrt((req_out - vco_f)**2);
			if ( error < best_error) begin
				best_error=error;
				best_N = N;//N_local;
				best_M = M;
				best_vco_f = vco_f;
				$display("Core %2d: PLL N=%5d M=%5d gives %1.4e Hz with deviation %1.4e Hz",1,N,M,vco_f,error);
			end
		end
	end
end
$display("Final Result");
$display("Core %2d: PLL N=%5d M=%5d gives %1.4e Hz with deviation %1.4e Hz" ,1,best_N,best_M,best_vco_f,best_error);
end

endprogram

//3vm

