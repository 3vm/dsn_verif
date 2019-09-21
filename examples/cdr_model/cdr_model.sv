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
					min_period = 0.5 * this_period + 0.5 * min_period;
					$display ("Period changed %1.3e" , min_period);
					$display ("Period %1.3e" , this_period);
				end
			
		
	end
end

initial begin
	bit new_data_transition;
	clkout = 0 ;
	forever begin
		new_data_transition = 0 ;
	    fork 
	    	begin
				#(min_period/2.0);
				clkout= ~clkout;
			end
			begin
				@(data_in);
				new_data_transition = 1;				
			end
		join_any
		disable fork;
	end
end

initial 
	$monitor("Clock %b , data %b , time %t", clkout,data_in, $realtime());

endmodule