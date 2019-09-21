module cdr_model 
(
input logic data_in,
output logic clkout,
output logic lock
);

timeunit 1ns;
timeprecision 1ps;

localparam CDR_LOCKING_WINDOW=20;
localparam realtime NATIVE_CLOCK_PERIOD=40;

realtime period_avg, this_period;
realtime curr_edge, prev_edge,min_period;

initial begin
	repeat (CDR_LOCKING_WINDOW) @(data_in);
	lock = 1;
end

initial begin
	prev_edge = $realtime();
	min_period=NATIVE_CLOCK_PERIOD;
	forever @(data_in) begin
		curr_edge = $realtime();
		this_period = curr_edge - prev_edge;
		prev_edge = curr_edge;
		if ( min_period > this_period ) begin
			$display ("Shrink: Min period %1.5e" , min_period);
			$display ("Shrink: This period %1.5e" , this_period);
			min_period = 0.5 * this_period + 0.5 * min_period;
		end	else if ( min_period > 0.95 * this_period  && min_period < 1.05 * this_period ) begin
			$display ("Expand: Min period %1.5e" , min_period);
			$display ("Expand: This period %1.5e" , this_period);
			min_period = 0.5 * this_period + 0.5 * min_period;
		end
	end
end

initial begin
	clkout = 0 ;
	forever begin
	    fork 
	    	begin
				#(min_period/2.0);
				clkout= 1;
				#(min_period/2.0);
				clkout= 0;
			end
			begin
				@(data_in);
			end
		join_any
		disable fork;
		clkout=0;
	end
end

initial 
	$monitor("Clock %b , data %b , time %t", clkout,data_in, $realtime());

endmodule