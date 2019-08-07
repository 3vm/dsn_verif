
module tb ;

timeunit 1ns;
timeprecision 1ps;

real integral, ana_in, step;
logic rstn;

localparam real RST_VAL = 0 ;
localparam realtime DT_STEP_SIZE = 1e-12; // to be matched to integration forever loop time step
localparam real SCALE_FACTOR = 1.0;
//COMMON MODE value?
localparam real INTEG_MAX = 1.0;
localparam real INTEG_MIN = 1.0;

initial begin
	integral = RST_VAL;
	forever begin
		#1ps;
		step = ana_in * DT_STEP_SIZE * SCALE_FACTOR ;
		if ( integral + step > INTEG_MAX ) begin
			integral = INTEG_MAX ;
		end else if ( integral + step < INTEG_MIN ) begin
			integral = INTEG_MIN ;
		end else begin
			integral += step;
		end
	end
end

initial begin
	forever begin
		#20ps;
		$display("Input %1.3f Step %1.3f Integral %1.3f Current time %t",ana_in,step, integral,$realtime());
	end
end

initial begin
	ana_in = 0 ;
	#0.9ns;
	rstn = 0; 
	#1.9ns;
	rstn = 1; ana_in = 1;
	#20ns;
end

endmodule
