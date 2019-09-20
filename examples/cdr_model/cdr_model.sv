module cdr_model 
(
input logic data_in,
output logic clkout,
output logic lock
);

timeunit 1ns;
timeprecision 1ps;

localparam CDR_LOCKING_WINDOW=100;

realtime periods[$];
realtime curr_edge, prev_edge,min_period;
int edge_cnt ;

initial begin
	edge_cnt=0; prev_edge = $realtime();
	min_period=15;
	forever @(data_in) begin

		curr_edge = $realtime();
		periods.push_front(curr_edge - prev_edge);
		prev_edge = curr_edge;
		if ( edge_cnt != CDR_LOCKING_WINDOW )
			edge_cnt++;
		else begin 
			periods.pop_back();
			foreach (periods[i]) begin
				if ( min_period > periods[i] ) begin
					min_period = periods[i] ;
					$display ("Period changed %1.3e" , min_period);
					$display ("Period %1.3e" , periods[i]);
				end
			end
		end
	end
end

initial begin
	clkout = 0 ;
	forever begin
		#(min_period/2);
		clkout=1;
		#(min_period/2);
		clkout=0;
	end
end

endmodule