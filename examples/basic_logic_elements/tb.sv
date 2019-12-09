module tb ;

logic [3:0] abus, bbus,ybus,or_out_bus,and_out_bus;
logic clk, rst;
logic a,b;
logic y;

//OR gate
initial begin


y = a|b;
ybus = abus | bbus;
y = |{a,b};
y = |{abus};

if ( a )
	y = 1 ;
else if ( b )
	y = 1;
else
	y=0;
end

always_comb
	case ({a,b})
		'b00: y = 0;
		'b01: y = 1;
		'b10: y = 1;
		'b11: y = 1;
		default: y=0;
	endcase	


or i0 (yor1,a,b);
or i1[3:0] (or_out_bus,abus,bbus);

always_ff @(posedge clk or posedge rst) begin
	//your flops assigned here
end

//AND gate
initial begin

logic a,b;
logic y;


abus = 'b1010;
bbus = 'b0110;

y = a&b;
ybus = abus & bbus;
y = &{a,b};
y = &{abus};

y=0;
if ( a )
	if ( b )
		y = 1;
$display("and_out_bus");
end

always_comb
	case ({a,b})
		'b00: y = 0;
		'b01: y = 0;
		'b10: y = 0;
		'b11: y = 1;
		default: y=0;
	endcase	

and i2 (yand1,a,b);
and i3[3:0] (and_out_bus,abus,bbus);


endmodule
