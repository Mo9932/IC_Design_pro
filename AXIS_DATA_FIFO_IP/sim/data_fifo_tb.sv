`timescale 1ns/100ps
module data_fifo_tb (
);

    parameter FIFO_WIDTH = 32;

    bit m_axis_rst_n ;
    bit m_axis_clk   ;
    bit m_axis_tready;
    logic m_axis_tvalid;
    logic [FIFO_WIDTH-1:0]m_axis_tdata ;
   
    bit s_axis_rst_n  ;
    bit s_axis_clk    ;
    logic s_axis_tready ;
    bit s_axis_tvalid ;
    logic [FIFO_WIDTH-1:0]s_axis_tdata ;

    int correct =0 , error = 0 ;

    bit [31:0]mem_test[256]; // to test the output when reading

    AXIS_DATA_FIFO #(
        .FIFO_DEPTH (256) ,
        .FIFO_WIDTH (32)
    ) DUT (.*);

    initial begin
        forever begin
            #7.5 s_axis_clk = ~s_axis_clk;
        end
    end
    initial begin
        forever begin
            #13 m_axis_clk = ~m_axis_clk;
        end
    end
    
    initial begin

        m_axis_rst_n = 0 ;
        s_axis_rst_n = 0 ;

        @(negedge s_axis_clk)
        m_axis_rst_n = 1 ;
        s_axis_rst_n = 1 ;
        
        /*start write only test */
        s_axis_tvalid = 1 ;
        for(int i = 0 ; i< 260 ; i++)begin
            @(negedge s_axis_clk);
            if(s_axis_tready)begin
                s_axis_tdata = i;
                mem_test[i] = s_axis_tdata; 
            end
        end
        s_axis_tvalid = 0 ;

        /*start read only test */
        m_axis_tready = 1 ;
        for(int i = 0 ; i< 260 ; i++)begin
            @(negedge m_axis_clk);
            if(m_axis_tvalid)begin
                if(mem_test[i+1] == m_axis_tdata)
                    correct++ ; 
                else
                    error++ ;
            end
        end
        m_axis_tready = 0 ;


        $display("correct data is %0d, and currupted data is %0d", correct, error);

        $stop;

    end
endmodule