module fifo_rl #(
    parameter FIFO_DEPTH = 16,
    parameter FIFO_WIDTH = 32

) (
    input   logic   r_clk ,
    input   logic   rst_n ,
    input   logic   rd_en ,
 
    input   logic   [$clog2(FIFO_DEPTH):0]wptr2rl ,

    output   logic   [$clog2(FIFO_DEPTH):0]rptr2wl ,
    output   logic   [$clog2(FIFO_DEPTH)-1:0]r_addr  ,
    output   logic   empty 
);

    reg [$clog2(FIFO_DEPTH):0]rptr ;

    always_ff @( posedge r_clk or negedge rst_n ) begin
        if(!rst_n)begin 
            rptr     <= '0;
        end
        else if(rd_en && !empty)begin
            rptr <= rptr + 1 ;
        end
    end

    assign rptr2wl = (rptr >> 1) ^ rptr; // convert form binary to gray

    assign empty = (rptr2wl == wptr2rl)? 1 : 0 ;

    assign r_addr = rptr[$clog2(FIFO_DEPTH)-1:0] ;
    
endmodule