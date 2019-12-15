
module serial_xor (
input logic clk,
input logic rstn,
input logic a,
input logic b,
output logic xo,
output logic ready
);

logic mem[2], memnext[2];

typedef enum logic [2:0] {C0=0, C1=1, C2=2, C3=3, C4=4 } state_t;

state_t state, next;

always_comb
	next = state.next();

always_comb begin
	memnext = mem;
	ready = 0;
	xo = 0;
	case(state)
		C0: memnext[0] = ~b;
		C1: memnext[0] = mem[0] & a;
		C2: memnext[1] = ~a;
		C3: memnext[1] = mem[1] & b;
		C4: begin
				xo = mem[0] | mem[1];
				ready = 1;
			end
		default: begin
			memnext = mem;
			ready = 0;
			xo = 0;
		end
	endcase
end

always_ff @(posedge clk, negedge rstn)
	if ( !rstn ) begin
		mem <= '{default:0};
		state <= state.first();
	end else begin
		mem <= memnext;
		state <= next;
	end

endmodule

