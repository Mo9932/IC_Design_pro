module fifo_mem #(
    parameter FIFO_DEPTH = 16,
    parameter FIFO_WIDTH = 32

) (
    input   logic   wr_clk ,
    input   logic   rst_n ,
    input   logic   full  ,
    input   logic   empty  ,
    input   logic   w_en  ,
 
    input   logic   [$clog2(FIFO_DEPTH)-1:0]w_addr ,
    input   logic   [FIFO_WIDTH-1:0]w_data ,

    input   logic   [$clog2(FIFO_DEPTH)-1:0]r_addr ,
    output  logic   [FIFO_WIDTH-1:0]r_data 
);

    reg [FIFO_WIDTH-1:0] fifo_mem_reg [FIFO_DEPTH-1:0];

    always_ff @( posedge wr_clk or negedge rst_n ) begin : blockName
        if(!rst_n)begin
            for (int i = 0 ; i < FIFO_DEPTH ; i++) begin
                fifo_mem_reg [i] <= '0;
            end
        end
        else if(w_en && !full)begin
            fifo_mem_reg [w_addr] <= w_data;
        end
    end


    assign r_data = (empty == 1'b1) ? '0 : fifo_mem_reg[r_addr] ;
    
endmodule