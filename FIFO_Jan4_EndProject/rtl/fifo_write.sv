module fifo_write #(parameter  DATA_WIDTH  = 8,
                               PTR_WIDTH   = 4,
                               DEPTH_WIDTH = 16)
             ( input                         w_clk,
       	      input                         wresetn,
               input                         flush,         // set 1 to clear all values of FIFO
               input                         wr_enable, 
		         input [PTR_WIDTH:0]           read_ptr,
               output wire                   fifo_wr_enable, 
		         output reg                    full,
		         output reg [PTR_WIDTH:0]      write_ptr
                 
                                                           );
           //reg wr_enable_reg, wr_enable_next;
           wire                  msb_equal;
           wire                  lsb_equal;
           reg  [PTR_WIDTH:0]    read_ptr_d;  // want to keep the signal full unchanged 

      always_ff @(posedge w_clk or negedge wresetn) begin
         if (~wresetn) begin
            read_ptr_d <= 'd0;
         end
         else begin
            read_ptr_d <= read_ptr;
         end
      end
          
      always_ff@(posedge w_clk or negedge wresetn) begin
	   if ( wresetn == 0) begin
            write_ptr[PTR_WIDTH:0] <= 0;
	   end
        else begin   // resetn = 1
           if(wr_enable) begin 
              if(flush) begin 
                write_ptr[PTR_WIDTH:0] <= 0; 
              end
              else if (~full) begin 
                 write_ptr[PTR_WIDTH:0] <= write_ptr[PTR_WIDTH:0] + 4'b0001;
              end
              else begin
                 write_ptr[PTR_WIDTH:0] <= write_ptr[PTR_WIDTH:0];
              end
          end
           else begin
                 write_ptr[PTR_WIDTH:0] <= write_ptr[PTR_WIDTH:0];
           end
        end
      end
      // full bit is 01 cycle delay
      // always_ff@(posedge w_clk or negedge wresetn) begin
      //       if(wresetn == 0) begin 
      //             full <= 1'b0;
      //       end
      //       else begin 
      //          if ((!msb_equal)&&(lsb_equal)) begin
      //             full <= 1'b1;
      //          end
      //          else if (read_ptr_d == read_ptr) begin
      //             full <= full;
      //          end
      //          else begin // double check this bit, keep set to 1 ultil read pointer increase
      //             full <= 1'b0;
      //          end
      //   end
      // end
      always_comb begin 
         if ((!msb_equal)&&(lsb_equal)) begin
            full = 1'b1;
         end
         else if (read_ptr_d == read_ptr) begin
            full = full;
         end
         else begin // double check this bit, keep set to 1 ultil read pointer increase
            full = 1'b0;
         end
      end

  assign msb_equal = write_ptr[PTR_WIDTH]  ^ (~read_ptr[PTR_WIDTH]);
  assign lsb_equal = (write_ptr[PTR_WIDTH-1:0] == read_ptr[PTR_WIDTH-1:0])? 1:0;
  //assign full  =  (mem_addr_write ==( DEPTH_WIDTH - 1)&& msb_equal);
  //assign fifo_wr_enable = (wr_request && (full==0))?1:0;
//   assign fifo_wr_enable = (wr_enable && (!full)&& (!flush))? 1:0;    /* Set to 1 if wr_enable signal permitted written; full signal
                                                                        // was stilled not full of data; and flush signal was zero */
   assign fifo_wr_enable = (wr_enable && ~full)? 1:0;
endmodule