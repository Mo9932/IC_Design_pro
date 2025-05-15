module G2B #(
    parameter BIT_WIDTH = 5
) (
    input logic [BIT_WIDTH-1:0]g_in,
    output logic [BIT_WIDTH-1:0]b_out
);


    always_comb begin : binary2gray
        b_out[BIT_WIDTH-1] = g_in[BIT_WIDTH-1];
        for (int i = BIT_WIDTH-1 ; i > 0 ; i-- ) begin
            b_out[i-1] = g_in[i-1]^b_out[i];
        end
    end
    
endmodule