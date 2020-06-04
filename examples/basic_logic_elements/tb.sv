module tb ;

logic [3:0] abus, bbus,yabus,yobus,or_out_bus,and_out_bus;
logic clk, rst;
logic a,b;
logic ya,yo;
logic y1a,y1o;

//OR gate
initial begin


yo = a|b;
yobus = abus | bbus;
yo = |{a,b};
yo = |{abus};

if ( a )
	yo = 1 ;
else if ( b )
	yo = 1;
else
	yo=0;
end

always_comb
	case ({a,b})
		'b00: y1o = 0;
		'b01: y1o = 1;
		'b10: y1o = 1;
		'b11: y1o = 1;
		default: y1o=0;
	endcase	


or i0 (yor1,a,b);
or i1[3:0] (or_out_bus,abus,bbus);

always_ff @(posedge clk or posedge rst) begin
	//your flops assigned here
end

//AND gate
initial begin

abus = 'b1010;
bbus = 'b0110;

ya = a&b;
yabus = abus & bbus;
ya = &{a,b};
ya = &{abus};

ya=0;
if ( a )
	if ( b )
		ya = 1;
#0;
$display("and bus output %b",and_out_bus);
end

always_comb
	case ({a,b})
		'b00: y1a = 0;
		'b01: y1a = 0;
		'b10: y1a = 0;
		'b11: y1a = 1;
		default: y1a=0;
	endcase	

and i2 (yand1,a,b);
and i3[3:0] (and_out_bus,abus,bbus);

//Mux-demux
always_comb begin
	logic y1bmux,sel,muxin,demuxa,demuxb;
	y1bmux = sel ? a : b;

	case (sel) 
		'b0: y1bmux = b;
		'b1: y1bmux = a;
		default: y1bmux = b;
	endcase

	if ( sel )
		y1bmux = a;
	else
		y1bmux = b;

	if(sel) begin
		demuxa=muxin;
		demuxb=0;
	end else begin
		demuxa=0;
		demuxb=muxin;
	end

	case (sel) 
		'b0: begin demuxa = 0 ; demuxb = muxin ; end
		'b1: begin demuxa = muxin ; demuxb = 0 ; end
		default: begin demuxa = 0 ; demuxb = 0 ; end
	endcase

end

//encoder-decoder
always_comb begin
	logic [2:0]  encoded_out;
	logic [7:0] decode_in, decoded_out;
	//test input
	decode_in = 'b00100000;

	// enocoder part
	encoded_out = 0 ;
	for ( int i = 0 ; i < 8 ; i++ ) begin
 		if ( decode_in[i]) begin
 			encoded_out = i;
 			break;
 		end
 	end
 	
 	// decoder part
	decoded_out = 0 ;
 	decoded_out[encoded_out] = 1'b1;
end

endmodule
