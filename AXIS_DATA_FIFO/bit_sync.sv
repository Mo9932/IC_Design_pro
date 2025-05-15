module bit_sync #(
    parameter FIFO_DEPTH = 16 ,
    parameter NUM_STG = 2 
) (
    input logic clk   , 
    input logic rst_n ,
    input logic [$clog2(FIFO_DEPTH):0] bit_in,
    output logic [$clog2(FIFO_DEPTH):0] bit_sync
);

    (* ASYNC_REG = "TRUE" *) 
    reg [$clog2(FIFO_DEPTH):0] sync_reg [NUM_STG-1:0];

    always_ff @( posedge clk or negedge rst_n ) begin 
        if(!rst_n)begin
            for (int i = 0 ; i< NUM_STG ; i++ ) begin
                sync_reg[i] <= '0;
            end
        end
        else begin
            sync_reg[0] <= bit_in;
            for (int i = 0 ; i< NUM_STG-1 ; i++ ) begin
                sync_reg[i+1] <= sync_reg[i];
            end
            bit_sync <= sync_reg[NUM_STG-1];
        end
    end

endmodule