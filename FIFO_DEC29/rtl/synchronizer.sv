module fifo_synchronizer #(parameter PTR_WIDTH = 6)
                          ( input clk, 
                            input resetn,
                            input  [PTR_WIDTH:0] syn_ptr_in,
                            output [PTR_WIDTH:0] syn_ptr_out
                                                );
        reg [PTR_WIDTH-1:0] syn_ptr_in_d;
        reg [PTR_WIDTH-1:0] syn_ptr_in_2d;
    // using synchronous clk, using negative edge clk    
        // always_ff@(posedge clk) begin 
        //     if( resetn) begin 
        //         syn_ptr_in  <=  0;
        //         d_in        <=  0;
        //     end
        //     else begin
        //         syn_ptr_in  <= d_in;
        //         d_in        <= syn_ptr_out; 
        //     end
        // end
        always_ff@(posedge clk) begin 
            if( resetn) begin 
                syn_ptr_in_d    <=  'd0;
                syn_ptr_in_2d   <=  'd0;
            end
            else begin
                syn_ptr_in_d    <=  syn_ptr_in;
                syn_ptr_in_2d   <=  syn_ptr_in_d;
            end
        end

        assign syn_ptr_out      = syn_ptr_in_2d;
endmodule