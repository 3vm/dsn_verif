
module ds_adc_dig
	#(parameter WIDTH=8)
( 
	input logic clk_oversamp,
	input logic rstn,
	input logic clk,
	input logic comp_out,
	output logic signed [WIDTH-1:0] dig_out
) ;

//CHECKME - how to synchronize oversampled to regular clock domain
logic sync_clr ;
logic [WIDTH-1:0] cnt; //CHECKME, can use exact width as dig_out?

ehgu_cntr #(.WIDTH(WIDTH)) cntr (
.clk(clk_oversamp),
.rstn,
.sync_clr,
.en(comp_out),
.cnt
);

logic copy_cnt, ckdelayed,data_ready,data_ready_slow,load;
logic [WIDTH-1:0] cnt_copied;

//CHECKME CDC to be thorougly reviewed
ehgu_dly #(.DELAY(3)) delck (.clk(clk_oversamp),.rstn,.din(clk),.dout(ckdelayed));
ehgu_redge  gen_samp (.clk(clk_oversamp),.rstn,.din(ckdelayed),.redge(copy_cnt));

assign sync_clr = copy_cnt;

always_ff @(posedge clk_oversamp or negedge rstn) begin 
	if(~rstn) begin
		cnt_copied <= 0;
		data_ready <= 0;
	end else if (copy_cnt) begin
		cnt_copied <= cnt;
		data_ready <= ~data_ready;
	end
end

ehgu_rst_sync synchronize_rst (.clk(clk),.rstn_in(rstn_in),.rstn_out(rstn_synced));

ehgu_dly #(.DELAY(3)) delready (.clk(clk),.rstn(rstn_synced),.din(data_ready),.dout(data_ready_slow));
ehgu_edges  gen_load (.clk(clk),.rstn(rstn_synced),.din(data_ready_slow),.toggle(load),.redge(),.fedge());

logic signed [WIDTH-1:0] dig_scale_adjusted;
assign dig_scale_adjusted = cnt_copied - 50 ;

always_ff @(posedge clk or negedge rstn_synced) begin
	if(~rstn_synced) begin
		dig_out <= 0;
	end else if (load) begin
		dig_out <= dig_scale_adjusted;
	end
end

endmodule
