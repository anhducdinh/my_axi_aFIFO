module fifo_synchronizer #(parameter PTR_WIDTH = 4)
                          ( input clk, 
                            input resetn,
                            input  [PTR_WIDTH-1 :0] syn_ptr_in,
                            output [PTR_WIDTH-1 :0] syn_ptr_out
                                                );
        reg [PTR_WIDTH-1:0] d_in;
    // using synchronous clk, using negative edge clk    
        always_ff@(posedge clk) begin 
            if( resetn) begin 
                syn_ptr_in  <=  0;
                d_in        <=  0;
            end
            else begin
                syn_ptr_in  <= d_in;
                d_in        <= syn_ptr_out; 
            end
        end
endmodule