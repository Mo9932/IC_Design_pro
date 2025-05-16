module fifo_wl #(
    parameter FIFO_DEPTH = 16,
    parameter FIFO_WIDTH = 32

) (
    input   logic   w_clk ,
    input   logic   rst_n ,
    input   logic   wr_en ,
 
    input   logic   [$clog2(FIFO_DEPTH):0]rptr2wl ,

    output   logic   [$clog2(FIFO_DEPTH)-1:0]w_addr  ,
    output   logic   [$clog2(FIFO_DEPTH):0]wptr2rl ,
    output   logic   full 
);

    reg [$clog2(FIFO_DEPTH):0]wptr ;


    always_ff @( posedge w_clk or negedge rst_n ) begin : blockName
        if(!rst_n)begin 
            wptr     <= '0;
        end
        else if(wr_en && !full)begin
            wptr <= wptr + 1 ;
        end
    end

    assign wptr2rl = (wptr >> 1) ^ wptr; // convert form binary to gray


    assign full = ((rptr2wl[$clog2(FIFO_DEPTH)-1:0] == wptr[$clog2(FIFO_DEPTH)-1:0]) && (rptr2wl[$clog2(FIFO_DEPTH)] != wptr[$clog2(FIFO_DEPTH)]))? 1 : 0 ;

    assign w_addr = wptr[$clog2(FIFO_DEPTH)-1:0] ;
    
endmodule