program tb;
// Variables, input
real ref_freq=100e6;
real req_out=120e6;
real vco_min=25e5;
real vco_max=900e6;
int N_MAX=32768;
int M_MAX=8192;
int cores=4;

initial begin
	fork
		for(int i=0;i<cores;i++) begin
			search_mn(i);
		end
	join
end

task automatic search_mn (
input byte core=0
);
real vco_f=0;
real best_vco_f=0;
int best_N=0;
int best_M=0;
real best_error=1e20;
real error;

for (int N=1+core;N<=N_MAX;N=N+cores) begin
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
				$display("Core %2d: PLL N=%5d M=%5d gives %1.4e Hz with deviation %1.4e Hz",core,N,M,vco_f,error);
			end
		end
	end
end
$display("Final Result from core %2d: PLL N=%5d M=%5d gives %1.4e Hz with deviation %1.4e Hz" ,core,best_N,best_M,best_vco_f,best_error);

endtask

  logic vikram;
endprogram

//3vm

