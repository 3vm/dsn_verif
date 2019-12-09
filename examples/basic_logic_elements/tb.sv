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


endmodule
