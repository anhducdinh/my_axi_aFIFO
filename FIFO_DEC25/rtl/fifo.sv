module fifo     #(parameter      DATA_WIDTH  = 8,
                                 PTR_WIDTH   = 4,
                                 DEPTH_WIDTH = 16)
          (  
             input                      wresetn,
             input                      rresetn,
             input                      flush,
             input                      w_clk,
             input                      r_clk,
             input  [DATA_WIDTH-1:0]    write_data,
             input                      wr_enable,
             input                      rd_enable,
             output [DATA_WIDTH-1:0]    read_data,
             output                     fifo_wr_enable,
             output                     fifo_rd_enable,
             output                     full,
             output                     empty
                                                      );
     reg                         flush;
     reg  [PTR_WIDTH -1:0]       write_ptr;
     reg  [PTR_WIDTH -1:0]       read_ptr;
     wire [PTR_WIDTH -1:0]       w_addr, r_addr;
     
     assign w_addr  = write_ptr[PTR_WIDTH -1:0];
     assign r_addr  = read_ptr [PTR_WIDTH -1:0];
     
     fifo_synchronizer #(.PTR_WIDTH(6)) write_syn ( 
                                  .resetn       (wresetn),
                                  .clk          (w_clk),
                                  .syn_ptr_in   (write_ptr),
                                  .syn_ptr_out  (write_ptr_syn)

                                                            );
     fifo_synchronizer #(.PTR_WIDTH(6)) read_syn  (  
                                  .resetn       (rresetn),
                                  .clk          (r_clk),
                                  .syn_ptr_in   (read_ptr),
                                  .syn_ptr_out  (read_ptr_syn)

                                                            );
     fifo_mem #(. DATA_WIDTH(8),
                . PTR_WIDTH (6) ,
                . DEPTH_WIDTH(64))  
                FIFO_MEMORY     (
                                  .wresetn           (wresetn),
                                  .rresetn           (rresetn),
                                  .w_clk             (w_clk),
                                  .r_clk             (r_clk),
                                  .w_addr            (w_addr),
                                  .r_addr            (r_addr),
                                  .fifo_wr_enable    (fifo_wr_enable),
                                  .fifo_rd_enable    (fifo_rd_enable),
                                  .data_in           (write_data),
                                  .data_out          (read_data)

                                                             );
     fifo_write #(. DATA_WIDTH(8),
                  . PTR_WIDTH (6) ,
                  . DEPTH_WIDTH(64)) 
                   FIFO_WRITE      (
                                  .wresetn           (wresetn),
                                  .w_clk             (w_clk),
                                  .fifo_wr_enable    (fifo_wr_enable),
                                  .full              (full),
                                  .flush             (flush),
                                  .write_ptr         (write_ptr),
                                  .wr_enable         (wr_enable),
                                  .read_ptr          (read_ptr_syn)

                                                             );
                    
     fifo_read #(. DATA_WIDTH(8),
                 . PTR_WIDTH (6) ,
                 . DEPTH_WIDTH(64)) 
                  FIFO_READ (
                        .rresetn           (rresetn),
                        .r_clk             (r_clk),
                        .fifo_rd_enable    (fifo_rd_enable),
                        .empty             (empty),
                        .flush             (flush),
                        .write_ptr         (write_ptr_syn),
                        .rd_enable         (rd_enable),
                        .read_ptr          (read_ptr)
                                                         );
endmodule
    
