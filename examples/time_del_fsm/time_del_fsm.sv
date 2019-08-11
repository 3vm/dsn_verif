module time_del_fsm
(
input clk,
input rstn,
output logic final_out
);

localparam STATE1_WAIT = 3;
localparam STATE2_WAIT = 5;
localparam STATE3_WAIT = 4;

typedef enum logic [1:0] { IDLE=0,STATE1=1,STATE2=2,STATE3=3 } fsm_state_t;

fsm_state_t state, next_state, prev_state;

logic [2:0] cnt;
logic sync_clr;

always_ff @(posedge clk, negedge rstn) begin
if ( !rstn) begin
  state <= IDLE;
  prev_state <= IDLE;
end else begin
  state <= next_state;
  prev_state <= state;
end
end

always_comb begin
  next_state = IDLE;
  if ( state == IDLE ) begin
    next_state = STATE1;
  end else begin
    if ( state == STATE1 && cnt == STATE1_WAIT-1) begin
      next_state = STATE2;
    end else if ( state == STATE2 && cnt == STATE2_WAIT-1) begin
      next_state = STATE3;
    end else if ( state == STATE3 && cnt == STATE3_WAIT-1) begin
      next_state = STATE1;
    end else begin
      next_state = state;    
    end
  end      
end

ehgu_cntr cntr (
.clk,
.rstn,
.sync_clr,
.en(1'b1),
.cnt
);

assign final_out = (state==STATE3) && (cnt==(STATE3_WAIT-1)) ;
assign sync_clr = (next_state!=state);

endmodule