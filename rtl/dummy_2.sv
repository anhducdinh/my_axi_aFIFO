module dummy #( 
        parameter DATA_WIDTH = 8, 
        parameter ADDR_WIDTH = 8
    ) 
    (
    input                           s_axi_clk,
    input                           s_axi_resetn,
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

);
    reg 					axi_resetn; 	
	reg 					axi_clk;    	
	wire [ADDR_WIDTH-1:0]	axi_aw_addr; 	
	wire 					axi_aw_valid;	
	wire 					axi_aw_ready;
	wire [DATA_WIDTH-1:0]	axi_w_data; 	
	wire 					axi_w_valid; 	
	wire 					axi_w_ready; 	
	wire 					axi_w_last; 	
	wire [1:0]				axi_b_resp;  	
	wire 					axi_b_valid; 	
	wire 					axi_b_ready; 	
	wire					axi_b_error;
	wire [ADDR_WIDTH-1:0]	axi_ar_addr;	
	wire 					axi_ar_valid;	
	wire 					axi_ar_ready;	
	wire [DATA_WIDTH-1:0]	axi_r_data;		
	wire [1:0]				axi_r_resp;		
	wire 					axi_r_valid;	
	wire 					axi_r_ready;
	wire					axi_r_error;

    wire [ADDR_WIDTH-1:0]   address,r_addr,w_addr;
    wire [DATA_WIDTH-1:0]   wdata;
    wire [DATA_WIDTH-1:0]   rdata;
    wire                    csr_read_enable;
    wire                    csr_write_enable;



    axi_sub_inf #(
         .DATA_WIDTH(DATA_WIDTH)
        ,.ADDR_WIDTH(ADDR_WIDTH)
        )
        axi_subordinate_if // instance name
        (	// AW Channel
		 .s_axi_clk      	    (s_axi_clk    	)
		,.s_axi_resetn      	(s_axi_resetn 	)
		,.s_axi_awaddr      	(s_axi_awaddr 	)
		,.s_axi_awvalid      	(s_axi_awvalid	)
		,.s_axi_awready      	(s_axi_awready	)
							
		//W Channel   	
		,.s_axi_wdata        	(s_axi_wdata 	)
		,.s_axi_wvalid       	(s_axi_wvalid 	)
		,.s_axi_wready       	(s_axi_wready 	)
		,.s_axi_wlast        	(s_axi_wlast 	)
		
		//B Channel
		,.s_axi_bresp           (s_axi_bresp  	)
		,.s_axi_bvalid    	    (s_axi_bvalid 	)
		,.s_axi_bready     	    (s_axi_bready 	)
		// ,.BERROR		(axi_b_error	)
		
		// AR Channel
		,.s_axi_araddr       	(s_axi_araddr	)
		,.s_axi_arvalid  		(s_axi_arvalid	)
		,.s_axi_arready  		(s_axi_arready	)
		// R Channel
		,.s_axi_rdata	    	(s_axi_rdata		)
		,.s_axi_rresp	    	(s_axi_rresp		)
		,.s_axi_rvalid	    	(s_axi_rvalid	)
		,.s_axi_rready	    	(s_axi_rready	)
		// ,.RERROR		(axi_r_error	)
        // Interract port
        ,.r_addr                (r_addr)
        ,.w_addr                (w_addr)
        ,.wdata                 (wdata)
        ,.rdata                 (rdata)
        ,.csr_read_enable       (csr_read_enable)
        ,.csr_write_enable      (csr_write_enable)

        );

    IP #(
         .DATA_WIDTH(DATA_WIDTH)
        ,.ADDR_WIDTH(ADDR_WIDTH)
        )
        IP_inst
    (
         //.address               (address)
         .r_addr                (r_addr)
        ,.w_addr                (w_addr)
        ,.wdata                 (wdata)
        ,.rdata                 (rdata)
        ,.csr_read_enable       (csr_read_enable)
        ,.csr_write_enable      (csr_write_enable)
    );
    

endmodule
/*
    always @(posedge s_axi_clk or negedge s_axi_resetn) begin
        if (~s_axi_resetn) begin
        end
        else begin
        end
    end
    */