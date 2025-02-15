module fifo_read #(parameter  DATA_WIDTH  = 8,
                              PTR_WIDTH   = 4,
                              DEPTH_WIDTH = 16)
                 (   input                         r_clk,
                     input                         flush,
       	             input                         rresetn,
                     input                         rd_enable,
		                 input [PTR_WIDTH:0]           write_ptr,
                     output wire                   fifo_rd_enable, 
                     output reg                    empty,
                     output reg [PTR_WIDTH:0]      read_ptr
                                                           );
          
           wire                  msb_equal;
          //  wire [PTR_WIDTH -1:0] lsb_equal;
           wire                  lsb_equal;

           reg  [PTR_WIDTH:0]    write_ptr_d;
          // wire [PTR_WIDTH -1:0] mem_addr_read;
          // wire [PTR_WIDTH -1:0] mem_addr_write;
      always_ff @(posedge r_clk or negedge rresetn) begin
         if (~rresetn) begin
            write_ptr_d <= 'd0;
         end
         else begin
            write_ptr_d <= write_ptr;
         end
      end

      always_ff@(posedge r_clk or negedge rresetn) begin
	   if ( rresetn == 0) begin
            read_ptr[PTR_WIDTH:0] <= 0;
	   end
        else begin   // resetn = 1
           if(rd_enable) begin 
              if(flush) begin
                  read_ptr[PTR_WIDTH:0] <= 0;
              end
              else if (!empty)
                  read_ptr[PTR_WIDTH:0] <= read_ptr + 4'b0001;
              else
                  read_ptr[PTR_WIDTH:0] <= read_ptr[PTR_WIDTH:0];
              end
           else begin
                 read_ptr[PTR_WIDTH:0] <= read_ptr[PTR_WIDTH:0];
           end
        end
      end
      
    //   always_ff@(posedge r_clk or negedge rresetn) begin
    //     if(rresetn == 0) begin 
    //         empty <= 1'b0;
    //     end
    //     else begin
    //       // if ((msb_equal)&&(lsb_equal)&&(flush)) begin
    //       if ((msb_equal)&&(lsb_equal)) begin
    //         empty <= 1'b1;
    //       end
    //       else if (write_ptr == write_ptr_d) begin
    //         empty <= empty;
    //       end
    //       else begin // double check this bit, keep set to 1 ultil write pointer increase
    //         empty <= 1'b0;
    //       end
    //   end
    // end

    always_ff@(posedge r_clk or negedge rresetn) begin
      if ((msb_equal)&&(lsb_equal)) begin
        empty <= 1'b1;
      end
      else if (write_ptr == write_ptr_d) begin
        empty <= empty;
      end
      else begin // double check this bit, keep set to 1 ultil write pointer increase
        empty <= 1'b0;
      end
    end


  assign  msb_equal = write_ptr[PTR_WIDTH] ^ (~read_ptr[PTR_WIDTH]);
  assign  lsb_equal = (write_ptr[PTR_WIDTH-1:0] == read_ptr[PTR_WIDTH-1:0])? 1:0;
  assign fifo_rd_enable = (rd_enable && (!empty)&&(!flush))? 1:0;
endmodule