module fifo_tb (
);

    parameter  FIFO_DEPTH = 16 ;
    parameter  FIFO_WIDTH = 32 ;

    bit   rd_clk      ;
    bit   wr_clk      ;
    bit   rd_rst_n    ;
    bit   wr_rst_n    ;
    bit   wr_en       ;
    bit   rd_en       ;
    bit   [FIFO_WIDTH-1:0] wr_data;

    logic [FIFO_WIDTH-1:0] rd_data;
    logic full    ;
    logic empty   ;    

    initial begin 
        forever begin
            #11 rd_clk = ~rd_clk;
        end
    end
    initial begin 
        forever begin
            #7 wr_clk = ~wr_clk;
        end
    end

    fifo_top #(
        .FIFO_DEPTH(FIFO_DEPTH),
        .FIFO_WIDTH(FIFO_WIDTH)
    ) DUT (.*);

    initial begin
        rd_rst_n    = 0;
        wr_rst_n    = 0;
        wr_en       = 0;
        rd_en       = 0;

        @(negedge wr_clk)
            wr_rst_n    = 1;

        @(negedge rd_clk)
            rd_rst_n    = 1;

        repeat(1000)begin
            @(negedge wr_clk)
            wr_en       = $random();
            rd_en       = $random();
            wr_data     = $random();
        end

        $stop;
    end
endmodule