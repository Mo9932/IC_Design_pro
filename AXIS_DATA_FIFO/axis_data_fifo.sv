module AXIS_DATA_FIFO #(
    parameter FIFO_DEPTH = 16 ,
    parameter FIFO_WIDTH = 32
) (
    /* MASTER AXIS INTERFACE */
        input logic m_axis_rst_n ,
        input logic m_axis_clk ,
        input logic m_axis_tready ,
        output logic m_axis_tvalid ,
        output logic [FIFO_WIDTH-1:0]m_axis_tdata ,
    /* SLAVE AXIS INTERFACE */
        input logic s_axis_rst_n ,
        input logic s_axis_clk ,
        output logic s_axis_tready ,
        input logic s_axis_tvalid ,
        input logic [FIFO_WIDTH-1:0]s_axis_tdata 
);

    wire full  ;
    wire empty ;

    fifo_top #(
        .FIFO_DEPTH(FIFO_DEPTH),
        .FIFO_WIDTH(FIFO_WIDTH)
    ) FIFO (
        .wr_clk         (s_axis_clk     ),
        .wr_rst_n       (s_axis_rst_n   ),
        .wr_en          (s_axis_tvalid  ),
        .wr_data        (s_axis_tdata   ),
        .full           (full           ),

        .rd_rst_n       (m_axis_rst_n   ),
        .rd_clk         (m_axis_clk     ),
        .empty          (empty          ),
        .rd_en          (m_axis_tready  ),
        .rd_data        (m_axis_tdata   )
    );

    assign s_axis_tready = !full ;
    assign m_axis_tvalid = !empty ;

endmodule