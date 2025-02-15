module fifo_top#( 
        parameter DATA_WIDTH = 8, 
        parameter ADDR_WIDTH = 8
    )
    (
    /*
    //--------------------------------------------
    // DATA INTERFACE
    //--------------------------------------------
    // Write side   
    input                           s_axi_wclk,
    input                           s_axi_wresetn,
    // AW CHANNEL
    input       [ADDR_WIDTH-1:0]    s_axi_awaddr,
    input                           s_axi_awvalid,
    output reg                      s_axi_awready,
    // W CHANNEL
    input       [DATA_WIDTH-1:0]    s_axi_wdata,
    input                           s_axi_wvalid,
    output reg                      s_axi_wready,
    input                           s_axi_wlast,
    // B CHANNEL
    input                           s_axi_bready,
    output reg  [1:0]               s_axi_bresp,
    output reg                      s_axi_bvalid,
    // Read side
    input                           s_axi_rclk,
    input                           s_axi_rresetn,
    // AR CHANNEL
    input       [ADDR_WIDTH-1:0]    s_axi_araddr,
    input                           s_axi_arvalid,
    output reg                      s_axi_arready,    
    // R CHANNEL
    output reg  [DATA_WIDTH-1:0]    s_axi_rdata,
    output reg                      s_axi_rvalid,
    input                           s_axi_rready,
    output reg                      s_axi_rlast,
    input                           s_axi_rresp
    */
    //--------------------------------------------
    // CSR INTERFACE
    //--------------------------------------------
    input                           csr_clk,
    input                           csr_resetn,
    // AW CHANNEL
    input       [ADDR_WIDTH-1:0]    csr_awaddr,
    input                           csr_awvalid,
    output reg                      csr_awready,
    // W CHANNEL
    input       [DATA_WIDTH-1:0]    csr_wdata,
    input                           csr_wvalid,
    output reg                      csr_wready,
    input                           csr_wlast,
    // B CHANNEL
    input                           csr_bready,
    output reg  [1:0]               csr_bresp,
    output reg                      csr_bvalid,
    // AR CHANNEL
    input       [ADDR_WIDTH-1:0]    csr_araddr,
    input                           csr_arvalid,
    output reg                      csr_arready,    
    // R CHANNEL
    output reg  [DATA_WIDTH-1:0]    csr_rdata,
    output reg                      csr_rvalid,
    input                           csr_rready,
    output reg                      csr_rlast,
    input                           csr_rresp

    // DATA INTERFACE
    input                           w_clk,
    input                           write_enable,
    input       [DATA_WIDTH-1:0]    write_data,
    input                           r_clk,
    input                           read_enable,
    output      [DATA_WIDTH-1:0]    read_data

);
    wire                            flush;
    wire                            full, empty;

    `define                         FIFO_CTRL   8'h0
    `define                         FIFO_STATUS 8'h1
    
    axi_sub_inf csr_if(
    // To Manager interface    
     .s_axi_clk                   (csr_clk)     
    ,.s_axi_resetn                (csr_resetn)        
    ,.s_axi_awaddr                (csr_awaddr)        
    ,.s_axi_awvalid               (csr_awvalid)         
    ,.s_axi_awready               (csr_awready)         
    ,.s_axi_wdata                 (csr_wdata)       
    ,.s_axi_wvalid                (csr_wvalid)        
    ,.s_axi_wready                (csr_wready)        
    ,.s_axi_wlast                 (csr_wlast)       
    ,.s_axi_bready                (csr_bready)        
    ,.s_axi_bresp                 (csr_bresp)       
    ,.s_axi_bvalid                (csr_bvalid)        
    ,.s_axi_araddr                (csr_araddr)        
    ,.s_axi_arvalid               (csr_arvalid)         
    ,.s_axi_arready               (csr_arready)             
    ,.s_axi_rdata                 (csr_rdata)       
    ,.s_axi_rvalid                (csr_rvalid)        
    ,.s_axi_rready                (csr_rready)        
    ,.s_axi_rlast                 (csr_rlast)       
    ,.s_axi_rresp                 (csr_rresp)
    // To internal register       
    ,.w_addr                      (csr_w_addr)  
    ,.r_addr                      (csr_r_addr)  
    ,.wdata                       (csr_wdata) 
    ,.rdata                       (csr_rdata) 
    ,.csr_read_enable             (csr_read_enable)           
    ,.csr_write_enable            (csr_write_enable)            
    );

    /*
    axi_sub_read_interface read_if(
            // TO READ MANAGER               
             .s_axi_rclk          (s_axi_rclk)          
            ,.s_axi_rresetn       (s_axi_rresetn)              
            // ,.s_axi_araddr        (s_axi_araddr)             
            // ,.s_axi_arvalid       (s_axi_arvalid)              
            // ,.s_axi_arready       (s_axi_arready)                  
            ,.s_axi_rdata         (s_axi_rdata)            
            ,.s_axi_rvalid        (s_axi_rvalid)             
            ,.s_axi_rready        (s_axi_rready)             
            ,.s_axi_rlast         (s_axi_rlast)           
            ,.s_axi_rresp         (s_axi_rresp)
            // TO FIFO                           
            // ,.r_addr              (r_addr)       
            ,.rdata               (rdata)      
            ,.read_enable         (read_enable)
        );

    axi_sub_write_interface write_if(
            // TO WRITER MANAGER
             .s_axi_wclk         (s_axi_wclk)          
            ,.s_axi_wresetn      (s_axi_wresetn)             
            // ,.s_axi_awaddr       (s_axi_awaddr)             
            // ,.s_axi_awvalid      (s_axi_awvalid)              
            // ,.s_axi_awready      (s_axi_awready)              
            ,.s_axi_wdata        (s_axi_wdata)            
            ,.s_axi_wvalid       (s_axi_wvalid)             
            ,.s_axi_wready       (s_axi_wready)             
            ,.s_axi_wlast        (s_axi_wlast)            
            ,.s_axi_bready       (s_axi_bready)             
            ,.s_axi_bresp        (s_axi_bresp)            
            ,.s_axi_bvalid       (s_axi_bvalid)
            // TO FIFO               
            // ,.w_addr             (w_addr)       
            ,.wdata              (wdata)      
            ,.write_enable       (write_enable)                
        );
    
    */
    fifo u_fifo
            (  
            .wresetn           (wresetn) 
            ,.rresetn          (rresetn)  
            ,.flush            (flush)
            ,.w_clk            (w_clk)
            ,.r_clk            (r_clk)
            ,.write_data       (write_data)     
            ,.wr_enable        (write_enable)    
            ,.rd_enable        (read_enable)    
            ,.read_data        (read_data)    
            // ,.fifo_wr_enable   (fifo_wr_enable)         
            // ,.fifo_rd_enable   (fifo_rd_enable)         
            ,.full             (full)
            ,.empty            (empty)
            );

    always_ff @(posedge csr_clk or negedge csr_resetn) begin
        if (~csr_resetn) begin
            flush <= 1'b0;
        end
        else begin
            if (csr_write_enable) begin
                case (csr_w_addr)
                `FIFO_CTRL: begin
                                flush <= csr_wdata[0];
                            end 

                `FIFO_STATUS: begin
                                //
                            end
                endcase
            end
        end
    end

    always_ff @(posedge csr_clk or negedge csr_resetn) begin
        if (~csr_resetn) begin
            csr_rdata <= 8'd0;
        end
        else begin
            if (csr_read_enable) begin
                case (csr_r_addr)
                `FIFO_CTRL: begin
                                csr_rdata[0] <= flush;
                                csr_rdata[7:1] <= 7'd0;
                            end 

                `FIFO_STATUS: begin
                                csr_rdata[0] <= empty;
                                csr_rdata[1] <= full;
                                csr_rdata[7:2] <= 6'd0;
                            end
                endcase
            end
        end
    end



endmodule