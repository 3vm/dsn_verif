module dl_slp_dig 
#( parameter RESOLUTION=8 )
(
 input logic clk ,
 input logic rstn ,
 input logic cmp_out ,
 input logic start ,

 output logic [ 7 : 0 ] dig_out ,
 output logic integrator_sel,
 output logic integrator_rstn,
 output logic eoc
 ) ;
localparam MAX_CNT = 2**RESOLUTION-1;
logic [ RESOLUTION -1 : 0 ] cnt ;
logic sync_clr, cnt_en ;

ehgu_cntr #(.WIDTH(8)) cntr (
.clk ,
.rstn ,
.sync_clr ,
.en ( cnt_en ) ,
.cnt
 ) ;

typedef enum logic [ 2 : 0 ] { IDLE = 0 , INIT = 1 , INTG_INPUT = 2 , INTG_VREF = 3, DONE=4 } fsm_state_t ;

fsm_state_t state , next_state , prev_state ;

always_ff @ ( posedge clk , negedge rstn ) begin
  if ( !rstn ) begin
     state <= IDLE ;
     prev_state <= IDLE ;
  end else begin
     state <= next_state ;
     prev_state <= state ;
  end
end

always_comb begin
   next_state = state ;
   if ( state == IDLE && start==1 ) begin
     next_state = INIT ;
   end else begin
//     if ( state == STATE1 && cnt == STATE1_WAIT-1 ) begin
     if ( state == INIT ) begin
       next_state = INTG_INPUT ;
     end else if ( state == INTG_INPUT && cnt == MAX_CNT ) begin
       next_state = INTG_VREF ;
     end else if ( state == INTG_VREF && (cmp_out==1 | cnt==MAX_CNT) ) begin
       next_state = DONE ;
     end else begin
       next_state = state ;
     end
   end
end

assign sync_clr = start ;
assign dig_out  = (state == DONE) ? cnt : 0 ;
assign eoc = (state == DONE);
assign cnt_en = (state == INTG_VREF) | (state == INTG_INPUT);
assign integrator_sel = (state==INTG_INPUT) ? 1 : 0 ;
assign integrator_rstn = cnt_en;

initial $monitor("cnt %d, state %s",cnt, state.name());

always @(posedge clk) begin
  $display("State %s, cnt_en %b, integrator_sel %b, integrator_rstn %b", state.name(), cnt_en, integrator_sel, integrator_rstn);
end

  logic vikram;
endmodule
