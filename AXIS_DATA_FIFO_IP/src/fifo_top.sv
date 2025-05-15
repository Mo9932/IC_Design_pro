module fifo_top #(
    parameter FIFO_DEPTH = 16,
    parameter FIFO_WIDTH = 32,
    parameter SYNC_STAGES = 2
) (
    input   logic   rd_clk      ,
    input   logic   wr_clk      ,
    input   logic   rd_rst_n    ,
    input   logic   wr_rst_n    ,
    input   logic   wr_en       ,
    input   logic   rd_en       ,
    input   logic   [FIFO_WIDTH-1:0] wr_data,

    output  logic   [FIFO_WIDTH-1:0] rd_data,
    output  logic   full    ,
    output  logic   empty   
);

    wire [$clog2(FIFO_DEPTH)-1:0] r_addr;
    wire [$clog2(FIFO_DEPTH)-1:0] w_addr;

    wire [$clog2(FIFO_DEPTH):0] wptr2rl_sync;
    wire [$clog2(FIFO_DEPTH):0] wptr2rl;
    wire [$clog2(FIFO_DEPTH):0] rptr2wl_sync;
    wire [$clog2(FIFO_DEPTH):0] rptr2wl;

    fifo_mem #(
        .FIFO_DEPTH (FIFO_DEPTH),
        .FIFO_WIDTH (FIFO_WIDTH)

    ) FIFO_MEM (
        .wr_clk  (wr_clk ),
        .rst_n  (wr_rst_n),
        .full   (full  ),
        .empty  (empty ),
        .w_en   (wr_en ),
        .w_addr (w_addr),
        .w_data (wr_data),
        .r_addr (r_addr),
        .r_data (rd_data)
    );

    fifo_rl #(
        .FIFO_DEPTH (FIFO_DEPTH),
        .FIFO_WIDTH (FIFO_WIDTH)

    ) FIFO_RD_LOGIC (
        .r_clk      (rd_clk     ),
        .rst_n      (rd_rst_n   ),
        .rd_en      (rd_en      ),
        .wptr2rl    (wptr2rl_sync),
        .rptr2wl    (rptr2wl    ),
        .r_addr     (r_addr     ),
        .empty     (empty      ) 
    );

    fifo_wl #(
        .FIFO_DEPTH (FIFO_DEPTH),
        .FIFO_WIDTH (FIFO_WIDTH)
    ) FIFO_WR_LOGIC(
        .w_clk      (wr_clk     ),
        .rst_n      (wr_rst_n   ),
        .wr_en      (wr_en      ),
        .rptr2wl    (rptr2wl_sync),
        .w_addr     (w_addr     ),
        .wptr2rl    (wptr2rl    ),
        .full       (full)
    );


    bit_sync #(
        .FIFO_DEPTH (FIFO_DEPTH),
        .NUM_STG(SYNC_STAGES)
    ) RD2WR(
        .clk        (wr_clk         ), 
        .rst_n      (wr_rst_n       ),
        .bit_in     (rptr2wl        ),
        .bit_sync   (rptr2wl_sync   )
    );

    bit_sync #(
        .FIFO_DEPTH (FIFO_DEPTH),
        .NUM_STG(SYNC_STAGES)
    ) WR2RD(
        .clk        (rd_clk         ), 
        .rst_n      (rd_rst_n       ),
        .bit_in     (wptr2rl        ),
        .bit_sync   (wptr2rl_sync   )
    );


endmodule