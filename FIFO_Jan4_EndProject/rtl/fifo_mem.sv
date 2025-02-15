module fifo_mem #(parameter DATA_WIDTH  = 8,
                  parameter PTR_WIDTH   = 4,
                  parameter DEPTH_WIDTH = 16)
             ( 
                input[DATA_WIDTH-1:0] data_in,
                 input w_clk,
                 input r_clk,
                 input rresetn,
                 inout wresetn,
                 input fifo_wr_enable, fifo_rd_enable,
                 input flush,
                 input [PTR_WIDTH-1:0] w_addr, r_addr,
                 //input [PTR_WIDTH-1:0] wr_ptr, rd_ptr,
                 output reg [DATA_WIDTH-1:0] data_out   //output wire [DATA_WIDTH-1:0] data_out
                                       );
       
   reg [DEPTH_WIDTH-1:0][DATA_WIDTH-1:0] mem_array ;
  // reg full, empty;
   //reg wr_en, rd_en; 
    genvar i;
    generate
      for (i=0;i <DEPTH_WIDTH;i = i+1) begin
        always_ff@(posedge w_clk, negedge wresetn) begin
          if(!wresetn) begin
            mem_array[i] <= 'd0;     // mem_array = 0 ?
          end
          else begin    
            if(flush) begin 
              mem_array[i] <= 'd0;
            end
            else begin
              if(fifo_wr_enable&&(w_addr==i)) begin 
                mem_array[i] <= data_in;
              end
              else begin
                mem_array[i] <= mem_array[i];
              end
            end
          end
        end
      end
    endgenerate 
      
      always_ff@(posedge r_clk, negedge rresetn) begin
        if(!rresetn) begin
          data_out  <=  0;
        end
        else if(flush) begin 
          data_out  <=  0;
        end
        else begin
           if(fifo_rd_enable) begin 
               data_out <= mem_array[r_addr[PTR_WIDTH-1:0]];
           end
           else begin
               data_out <= data_out;
           end
        end 
      end

 //assign data_out = mem_array[r_addr[PTR_WIDTH-1:0]];  
 //assign fifo_wr_enable = (~full)  & wr_enable;
 //assign fifo_rd_enable = (~empty) & rd_enable;
endmodule 